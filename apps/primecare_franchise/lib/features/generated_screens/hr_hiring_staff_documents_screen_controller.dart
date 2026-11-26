// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringStaffDocumentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final hrHiringStaffDocumentsScreenControllerProvider =
    NotifierProvider<
      HrHiringStaffDocumentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringStaffDocumentsScreenController();
    });

class HrHiringStaffDocumentsScreenController extends BaseScaffoldController {}
