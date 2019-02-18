import '../library.dart';
import 'package:mastodon/mock/mixins/timelines.dart';

mixin Timelines on Authentication implements MockTimelinesMixin {
  /// GET /api/v1/timelines/home
  /// https://docs.joinmastodon.org/api/rest/timelines/#get-api-v1-timelines-home
  Future<List<Status>> timeline({
    String maxId,
    String sinceId,
    String minId,
    int limit = 20,
  }) async {
    assert(key != null);

    final uri = Uri(
      scheme: baseUrl.scheme,
      host: baseUrl.host,
      path: "/api/v1/timelines/home",
      queryParameters: {
        "max_id": maxId,
        "since_id": sinceId,
        "min_id": minId,
        "limit": limit,
      },
    );

    final response = await get(
      uri,
      headers: {"Authorization": "Bearer $key"},
    );

    return List<Status>.from(
      json.decode(response.body).map((json) => Status.fromJson(json)),
    );
  }

  /// GET /api/v1/conversations
  /// https://docs.joinmastodon.org/api/rest/timelines/#get-api-v1-conversations
  Future<List<Conversation>> conversations({
    String maxId,
    String sinceId,
    String minId,
    int limit = 20,
  }) async {
    assert(key != null);

    final uri = Uri(
      scheme: baseUrl.scheme,
      host: baseUrl.host,
      path: "/api/v1/conversations",
      queryParameters: {
        "max_id": maxId,
        "since_id": sinceId,
        "min_id": minId,
        "limit": "$limit",
      },
    );

    final response = await get(
      uri,
      headers: {"Authorization": "Bearer $key"},
    );

    return List<Conversation>.from(
      json.decode(response.body).map((json) => Conversation.fromJson(json)),
    );
  }

  /// GET /api/v1/timelines/public
  /// https://docs.joinmastodon.org/api/rest/timelines/#get-api-v1-timelines-public
  Future<List<Status>> publicTimeline({
    bool local,
    bool onlyMedia,
    String maxId,
    String sinceId,
    String minId,
    int limit = 20,
  }) =>
      throw UnimplementedError();

  /// GET /api/v1/timelines/tag/:hashtag
  /// https://docs.joinmastodon.org/api/rest/timelines/#get-api-v1-timelines-tag-hashtag
  Future<List<Status>> hashtagTimeline(
    String hashtag, {
    bool local,
    bool onlyMedia,
    String maxId,
    String sinceId,
    String minId,
    int limit = 20,
  }) =>
      throw UnimplementedError();

  /// GET /api/v1/timelines/list/:list_id
  /// https://docs.joinmastodon.org/api/rest/timelines/#get-api-v1-timelines-list-list-id
  Future<List<Status>> listTimeline(
    String id, {
    bool local,
    bool onlyMedia,
    String maxId,
    String sinceId,
    String minId,
    int limit = 20,
  }) =>
      throw UnimplementedError();
}
