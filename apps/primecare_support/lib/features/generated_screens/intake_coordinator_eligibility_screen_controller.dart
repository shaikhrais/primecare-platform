// Governance - Category: controller | Purpose: Non-executable scaffold for IntakeCoordinatorEligibilityScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final intakeCoordinatorEligibilityScreenControllerProvider =
    NotifierProvider<
      IntakeCoordinatorEligibilityScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IntakeCoordinatorEligibilityScreenController();
    });

class IntakeCoordinatorEligibilityScreenController
    extends BaseScaffoldController {}
