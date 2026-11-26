// Governance - Category: controller | Purpose: Non-executable scaffold for CommunityOutreachEventsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final communityOutreachEventsScreenControllerProvider =
    NotifierProvider<
      CommunityOutreachEventsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CommunityOutreachEventsScreenController();
    });

class CommunityOutreachEventsScreenController extends BaseScaffoldController {}
