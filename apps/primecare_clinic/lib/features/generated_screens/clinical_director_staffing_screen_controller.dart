// Governance - Category: controller | Purpose: Non-executable scaffold for ClinicalDirectorStaffingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final clinicalDirectorStaffingScreenControllerProvider =
    NotifierProvider<
      ClinicalDirectorStaffingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClinicalDirectorStaffingScreenController();
    });

class ClinicalDirectorStaffingScreenController extends BaseScaffoldController {}
