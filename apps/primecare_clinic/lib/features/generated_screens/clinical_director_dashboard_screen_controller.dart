// Governance - Category: controller | Purpose: Non-executable scaffold for ClinicalDirectorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final clinicalDirectorDashboardScreenControllerProvider =
    NotifierProvider<
      ClinicalDirectorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClinicalDirectorDashboardScreenController();
    });

class ClinicalDirectorDashboardScreenController
    extends BaseScaffoldController {}
