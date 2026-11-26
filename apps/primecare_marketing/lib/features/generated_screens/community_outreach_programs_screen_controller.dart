// Governance - Category: controller | Purpose: Non-executable scaffold for CommunityOutreachProgramsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final communityOutreachProgramsScreenControllerProvider =
    NotifierProvider<
      CommunityOutreachProgramsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CommunityOutreachProgramsScreenController();
    });

class CommunityOutreachProgramsScreenController
    extends BaseScaffoldController {}
