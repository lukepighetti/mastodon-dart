import '../library.dart';

import 'package:mastodon/mock/mixins/lists.dart';

mixin Lists on Authentication implements MockListsMixin {
  /// GET /api/v1/lists
  ///
  /// - authenticated (requires user)
  /// - read read:lists
  ///
  /// https://docs.joinmastodon.org/api/rest/lists/#get-api-v1-lists
  Future<List<ListSummary>> lists() async {
    assert(key != null);

    final uri = Uri(
      scheme: baseUrl.scheme,
      host: baseUrl.host,
      path: "/api/v1/lists",
    );

    final response = await get(
      uri,
      headers: {"Authorization": "Bearer $key"},
    );

    final body = List<Map>.from(json.decode(response.body));

    return body.map((m) => ListSummary.fromJson(m)).toList();
  }

  /// GET /api/v1/accounts/:id/lists
  ///
  /// - authenticated (requires user)
  /// - read read:lists
  ///
  /// https://docs.joinmastodon.org/api/rest/lists/#get-api-v1-accounts-id-lists
  Future<List<ListSummary>> listsByAccount(String id) async {
    assert(key != null);

    final uri = Uri(
      scheme: baseUrl.scheme,
      host: baseUrl.host,
      path: "/api/v1/accounts/$id/lists",
    );

    final response = await get(
      uri,
      headers: {"Authorization": "Bearer $key"},
    );

    final body = List<Map>.from(json.decode(response.body));

    return body.map((m) => ListSummary.fromJson(m)).toList();
  }

  /// GET /api/v1/lists/:id/accounts
  ///
  /// - authenticated (requires user)
  /// - read read:lists
  ///
  /// https://docs.joinmastodon.org/api/rest/lists/#get-api-v1-lists-id-accounts
  Future<List<Account>> listAccounts(String id, {int limit = 40}) async {
    assert(key != null);

    final uri = Uri(
      scheme: baseUrl.scheme,
      host: baseUrl.host,
      path: "/api/v1/lists/$id/accounts",
      queryParameters: {
        "limit": limit,
      },
    );

    final response = await get(
      uri,
      headers: {"Authorization": "Bearer $key"},
    );

    final body = List<Map>.from(json.decode(response.body));

    return body.map((m) => Account.fromJson(m)).toList();
  }

  /// GET /api/v1/lists/:id
  ///
  /// - authenticated (requires user)
  /// - read read:lists
  ///
  /// https://docs.joinmastodon.org/api/rest/lists/#get-api-v1-lists-id
  Future<ListSummary> list(String id) async {
    assert(key != null);

    final uri = Uri(
      scheme: baseUrl.scheme,
      host: baseUrl.host,
      path: "/api/v1/lists/$id",
    );

    final response = await get(
      uri,
      headers: {"Authorization": "Bearer $key"},
    );

    return ListSummary.fromJson(json.decode(response.body));
  }

  /// POST /api/v1/lists
  ///
  /// - authenticated (requires user)
  /// - write write:lists
  ///
  /// https://docs.joinmastodon.org/api/rest/lists/#post-api-v1-lists
  Future<ListSummary> createList(String title) async {
    assert(key != null);

    final uri = Uri(
      scheme: baseUrl.scheme,
      host: baseUrl.host,
      path: "/api/v1/lists",
      queryParameters: {
        "title": title,
      },
    );

    final response = await post(
      uri,
      headers: {"Authorization": "Bearer $key"},
    );

    return ListSummary.fromJson(json.decode(response.body));
  }

  /// PUT /api/v1/lists/:id
  ///
  /// - authenticated (requires user)
  /// - write write:lists
  ///
  /// https://docs.joinmastodon.org/api/rest/lists/#put-api-v1-lists-id
  Future<ListSummary> updateList(String id, String title) async {
    assert(key != null);

    final uri = Uri(
      scheme: baseUrl.scheme,
      host: baseUrl.host,
      path: "/api/v1/lists/$id",
      queryParameters: {
        "title": title,
      },
    );

    final response = await put(
      uri,
      headers: {"Authorization": "Bearer $key"},
    );

    return ListSummary.fromJson(json.decode(response.body));
  }

  /// DELETE /api/v1/lists/:id
  ///
  /// - authenticated (requires user)
  /// - write write:lists
  ///
  /// https://docs.joinmastodon.org/api/rest/lists/#delete-api-v1-lists-id
  Future<dynamic> deleteList(String id) async {
    assert(key != null);

    final uri = Uri(
      scheme: baseUrl.scheme,
      host: baseUrl.host,
      path: "/api/v1/lists/$id",
    );

    await delete(
      uri,
      headers: {"Authorization": "Bearer $key"},
    );
  }

  /// POST /api/v1/lists/:id/accounts
  /// https://docs.joinmastodon.org/api/rest/lists/#post-api-v1-lists-id-accounts
  ///
  /// - authenticated (requires user)
  /// - write write:lists
  ///
  /// Only accounts already followed by the user can be added to a list
  Future<dynamic> addAccountsToList(String id, List<String> ids) async {
    assert(key != null);

    final uri = Uri(
      scheme: baseUrl.scheme,
      host: baseUrl.host,
      path: "/api/v1/lists/$id/accounts",
      queryParameters: {
        "account_ids": ids,
      },
    );

    await post(
      uri,
      headers: {"Authorization": "Bearer $key"},
    );
  }

  /// DELETE /api/v1/lists/:id/accounts
  ///
  /// - authenticated (requires user)
  /// - write write:lists
  ///
  /// https://docs.joinmastodon.org/api/rest/lists/#delete-api-v1-lists-id-accounts
  Future<dynamic> deleteAccountsFromList(String id, List<String> ids) async {
    assert(key != null);

    final uri = Uri(
      scheme: baseUrl.scheme,
      host: baseUrl.host,
      path: "/api/v1/lists/$id/accounts",
      queryParameters: {
        "account_ids": ids,
      },
    );

    await delete(
      uri,
      headers: {"Authorization": "Bearer $key"},
    );
  }
}
