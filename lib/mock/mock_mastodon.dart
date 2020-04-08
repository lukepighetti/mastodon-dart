import 'package:mastodon_dart/mock/endpoints/bookmarks.dart';
import 'package:mastodon_dart/mock/endpoints/polls.dart';

import 'endpoints/accounts.dart';
import 'endpoints/apps.dart';
import 'endpoints/blocks.dart';
import 'endpoints/custom_emojis.dart';
import 'endpoints/domain_blocks.dart';
import 'endpoints/endorsements.dart';
import 'endpoints/favourites.dart';
import 'endpoints/filters.dart';
import 'endpoints/follow_requests.dart';
import 'endpoints/follow_suggestions.dart';
import 'endpoints/instances.dart';
import 'endpoints/lists.dart';
import 'endpoints/media_attachments.dart';
import 'endpoints/mutes.dart';
import 'endpoints/notifications.dart';
import 'endpoints/reports.dart';
import 'endpoints/scheduled_statuses.dart';
import 'endpoints/search.dart';
import 'endpoints/statuses.dart';
import 'endpoints/timelines.dart';

class MockMastodon = MockAuthentication
    with
        MockAccounts,
        MockApps,
        MockBlocks,
        MockBookmarks,
        MockCustomEmojis,
        MockDomainBlocks,
        MockEndorsements,
        MockFavourites,
        MockFilters,
        MockFollowRequests,
        MockFollowSuggestions,
        MockInstances,
        MockLists,
        MockMediaAttachments,
        MockMutes,
        MockNotifications,
        MockPolls,
        MockReports,
        MockScheduledStatuses,
        MockSearch,
        MockStatuses,
        MockTimelines;

class MockAuthentication {
  final Uri baseUrl;

  MockAuthentication(this.baseUrl);

  String token;
}
