// Governance - Category: controller | Purpose: Non-executable scaffold for IntakeCoordinatorIntakeFormsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final intakeCoordinatorIntakeFormsScreenControllerProvider =
    NotifierProvider<
      IntakeCoordinatorIntakeFormsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IntakeCoordinatorIntakeFormsScreenController();
    });

class IntakeCoordinatorIntakeFormsScreenController
    extends BaseScaffoldController {}
