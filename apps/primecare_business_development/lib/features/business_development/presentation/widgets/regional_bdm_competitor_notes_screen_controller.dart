// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmCompetitorNotesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalBdmCompetitorNotesScreenControllerProvider =
    NotifierProvider<
      RegionalBdmCompetitorNotesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmCompetitorNotesScreenController();
    });

class RegionalBdmCompetitorNotesScreenController
    extends BaseScaffoldController {}
