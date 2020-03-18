import 'dart:async';
import 'dart:convert';

import 'package:mastodon_dart/src/data/account.dart';
import 'package:mastodon_dart/src/data/application.dart';
import 'package:mastodon_dart/src/mastodon.dart';
import 'package:rxdart/rxdart.dart';

import 'package:http/http.dart' show post;

class AuthBloc {
  final AuthStorageDelegate storage;
  final Mastodon mastodon;

  final Uri website;
  final String redirectUris;
  final String clientName;
  final List<String> scopes;

  ///
  /// Authentication steps:
  ///
  /// 1. Listen to [AuthBloc.uri], navigate user to external browser on event.
  /// 2. The user will interact with the page to authenticate.
  ///   Default settings will have them copy-paste a code into your app.
  /// 3. Add the code to [AuthBloc.codeSink.add]
  /// 4. Listen to [AuthBloc.token], navigate the user to the homepage on event.
  ///
  /// Notes: Provide a [Mastodon] instance with a previous token to short-circuit the process.
  AuthBloc(
    this.mastodon,
    this.website, {
    this.storage,
    this.redirectUris = "urn:ietf:wg:oauth:2.0:oob",
    this.clientName = "mastodon-dart",
    this.scopes = const ["write", "read", "follow", "push"],
  }) {
    Future.value(storage?.fetchToken).then((token) async {
      final savedToken = mastodon.token ?? await token;

      _app.listen(_handleApplication);
      _code.listen(_handleCode);
      _token.listen(_handleToken);

      if (savedToken == null) {
        await _registerApplication();
      } else {
        _token.add(savedToken);
      }
    });
  }

  final _account = BehaviorSubject<Account>();
  final _app = BehaviorSubject<AuthenticatedApplication>();
  final _code = BehaviorSubject<String>();
  final _uri = BehaviorSubject<Uri>();
  final _token = BehaviorSubject<String>();

  Sink<String> get codeSink => _code.sink;

  ValueStream<Account> get account => _account.stream;
  ValueStream<Uri> get uri => _uri.stream;
  ValueStream<String> get token => _token.stream;

  /// Register the application and add it to [_app]
  Future _registerApplication() async {
    final application = await mastodon.appCredentials(
        website, redirectUris, clientName, scopes);

    _app.add(application);
  }

  /// Generate the Uri needed to authenticate the app. This
  /// uri will be navigated to for the user, preferably in an
  /// external browser to improve security.
  void _handleApplication(AuthenticatedApplication app) {
    assert(app?.clientId != null && app?.clientSecret != null);

    final uri = mastodon.authorizationUrl.replace(
      queryParameters: {
        "response_type": "code",
        "client_id": app.clientId,
        "client_secret": app.clientSecret,
        "redirect_uri": redirectUris,
        "scope": scopes.join(" "),
      },
    );

    _uri.add(uri);
  }

  /// Authenticate the [authCode] which should be provided
  /// by the oauth flow, such as a user copy-pasting the
  /// code from the browser.
  ///
  /// If the code validates, it will automatically trigger the
  /// authentication process. It does not wait for confirmation.
  Future<void> _handleCode(String code) async {
    final response = await post(
      mastodon.tokenUrl,
      body: {
        "client_id": _app.value.clientId,
        "client_secret": _app.value.clientSecret,
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": redirectUris,
      },
    );

    final results = Token.fromJson(jsonDecode(response.body));

    final token = results.accessToken;

    _token.add(token);
  }

  /// Saves, sets, and verifies a token.
  /// Then adds the [Account] to [_account.add]
  Future<void> _handleToken(String token) async {
    if (token != null) {
      if (storage != null && token != await storage.fetchToken) {
        await storage.saveToken(token);
      }

      mastodon.token = token;

      final account = await mastodon.verifyCredentials();

      _account.add(account);
    }
  }

  dispose() {
    _account.close();
    _app.close();
    _code.close();
    _uri.close();
    _token.close();
  }
}

/// A simple storage driver interface that allows
/// fetching and saving of a [token] as a string
abstract class AuthStorageDelegate {
  FutureOr<void> saveToken(String token);
  FutureOr<String> get fetchToken;
}
