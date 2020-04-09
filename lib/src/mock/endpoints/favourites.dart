import 'package:mastodon_dart/mastodon_dart.dart';

class MockFavourites {
  /// GET /api/v1/favourites
  /// https://docs.joinmastodon.org/api/rest/favourites/#get-api-v1-favourites
  ///
  /// TODO: implement link headers for pagination
  /// shall we return prepopulated Futures for next/prev page?
  Future<List<Status>> favourites({int limit = 40}) =>
      Future.value(List.generate(limit, (_) => Status.mock()));

  /// POST /api/v1/statuses/:id/favourite
  /// https://docs.joinmastodon.org/api/rest/favourites/#post-api-v1-statuses-id-favourite
  Future<Status> favourite(String id) => Future.value(Status.mock());

  /// POST /api/v1/statuses/:id/unfavourite
  /// https://docs.joinmastodon.org/api/rest/favourites/#post-api-v1-statuses-id-unfavourite
  Future<Status> unfavourite(String id) => Future.value(Status.mock());
}
