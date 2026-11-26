// Governance - Category: controller | Purpose: Non-executable scaffold for CommunityOutreachDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final communityOutreachDashboardScreenControllerProvider =
    NotifierProvider<
      CommunityOutreachDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CommunityOutreachDashboardScreenController();
    });

class CommunityOutreachDashboardScreenController
    extends BaseScaffoldController {}
