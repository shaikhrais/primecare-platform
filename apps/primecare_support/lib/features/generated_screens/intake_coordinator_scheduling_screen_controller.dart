// Governance - Category: controller | Purpose: Non-executable scaffold for IntakeCoordinatorSchedulingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final intakeCoordinatorSchedulingScreenControllerProvider =
    NotifierProvider<
      IntakeCoordinatorSchedulingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IntakeCoordinatorSchedulingScreenController();
    });

class IntakeCoordinatorSchedulingScreenController
    extends BaseScaffoldController {}
