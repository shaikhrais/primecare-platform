// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringApplicantsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final hrHiringApplicantsScreenControllerProvider =
    NotifierProvider<
      HrHiringApplicantsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringApplicantsScreenController();
    });

class HrHiringApplicantsScreenController extends BaseScaffoldController {}
