// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringOnboardingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final hrHiringOnboardingScreenControllerProvider =
    NotifierProvider<
      HrHiringOnboardingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringOnboardingScreenController();
    });

class HrHiringOnboardingScreenController extends BaseScaffoldController {}
