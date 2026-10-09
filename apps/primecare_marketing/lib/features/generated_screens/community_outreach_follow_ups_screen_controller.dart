// Governance - Category: controller | Purpose: Non-executable scaffold for CommunityOutreachFollowUpsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final communityOutreachFollowUpsScreenControllerProvider =
    NotifierProvider<
      CommunityOutreachFollowUpsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CommunityOutreachFollowUpsScreenController();
    });

class CommunityOutreachFollowUpsScreenController
    extends BaseScaffoldController {}
