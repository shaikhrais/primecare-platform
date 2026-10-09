// Governance - Category: controller | Purpose: Non-executable scaffold for CommunityOutreachReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final communityOutreachReportsScreenControllerProvider =
    NotifierProvider<
      CommunityOutreachReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CommunityOutreachReportsScreenController();
    });

class CommunityOutreachReportsScreenController extends BaseScaffoldController {}
