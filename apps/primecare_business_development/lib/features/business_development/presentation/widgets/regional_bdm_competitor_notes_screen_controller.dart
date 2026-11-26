// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmCompetitorNotesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final regionalBdmCompetitorNotesScreenControllerProvider =
    NotifierProvider<
      RegionalBdmCompetitorNotesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmCompetitorNotesScreenController();
    });

class RegionalBdmCompetitorNotesScreenController
    extends BaseScaffoldController {}
