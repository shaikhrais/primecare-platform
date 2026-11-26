// Governance - Category: controller | Purpose: Non-executable scaffold for ClinicalDirectorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final clinicalDirectorDashboardScreenControllerProvider =
    NotifierProvider<
      ClinicalDirectorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClinicalDirectorDashboardScreenController();
    });

class ClinicalDirectorDashboardScreenController
    extends BaseScaffoldController {}
