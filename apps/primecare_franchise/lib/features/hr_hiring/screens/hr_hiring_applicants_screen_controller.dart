// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringApplicantsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final hrHiringApplicantsScreenControllerProvider =
    NotifierProvider<
      HrHiringApplicantsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringApplicantsScreenController();
    });

class HrHiringApplicantsScreenController extends BaseScaffoldController {}
