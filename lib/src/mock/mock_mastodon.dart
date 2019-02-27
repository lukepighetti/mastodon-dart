import 'mixins/accounts.dart';
import 'mixins/apps.dart';
import 'mixins/blocks.dart';
import 'mixins/custom_emojis.dart';
import 'mixins/domain_blocks.dart';
import 'mixins/endorsements.dart';
import 'mixins/favourites.dart';
import 'mixins/filters.dart';
import 'mixins/follow_requests.dart';
import 'mixins/follow_suggestions.dart';
import 'mixins/instances.dart';
import 'mixins/lists.dart';
import 'mixins/media_attachments.dart';
import 'mixins/mutes.dart';
import 'mixins/notifications.dart';
import 'mixins/reports.dart';
import 'mixins/scheduled_statuses.dart';
import 'mixins/search.dart';
import 'mixins/statuses.dart';
import 'mixins/timelines.dart';

class MockMastodon = MockAuthentication
    with
        MockAccountsMixin,
        MockAppsMixin,
        MockBlocksMixin,
        MockCustomEmojisMixin,
        MockDomainBlocksMixin,
        MockEndorsementsMixin,
        MockFavouritesMixin,
        MockFiltersMixin,
        MockFollowRequestsMixin,
        MockFollowSuggestionsMixin,
        MockInstancesMixin,
        MockListsMixin,
        MockMediaAttachmentsMixin,
        MockMutesMixin,
        MockNotificationsMixin,
        MockReportsMixin,
        MockScheduledStatusesMixin,
        MockSearchMixin,
        MockStatusesMixin,
        MockTimelinesMixin;

class MockAuthentication {
  final Uri baseUrl;

  MockAuthentication(this.baseUrl);

  String key;
}