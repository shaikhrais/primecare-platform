// Governance - Category: controller | Purpose: Non-executable scaffold for CommunityOutreachReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final communityOutreachReportsScreenControllerProvider =
    NotifierProvider<
      CommunityOutreachReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CommunityOutreachReportsScreenController();
    });

class CommunityOutreachReportsScreenController extends BaseScaffoldController {}
