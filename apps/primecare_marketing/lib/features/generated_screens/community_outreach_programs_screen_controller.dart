// Governance - Category: controller | Purpose: Non-executable scaffold for CommunityOutreachProgramsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final communityOutreachProgramsScreenControllerProvider =
    NotifierProvider<
      CommunityOutreachProgramsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CommunityOutreachProgramsScreenController();
    });

class CommunityOutreachProgramsScreenController
    extends BaseScaffoldController {}
