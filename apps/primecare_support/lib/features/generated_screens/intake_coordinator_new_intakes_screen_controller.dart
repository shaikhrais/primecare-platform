// Governance - Category: controller | Purpose: Non-executable scaffold for IntakeCoordinatorNewIntakesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final intakeCoordinatorNewIntakesScreenControllerProvider =
    NotifierProvider<
      IntakeCoordinatorNewIntakesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IntakeCoordinatorNewIntakesScreenController();
    });

class IntakeCoordinatorNewIntakesScreenController
    extends BaseScaffoldController {}
