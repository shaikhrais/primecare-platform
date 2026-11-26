// Governance - Category: controller | Purpose: Non-executable scaffold for IntakeCoordinatorClientAssignmentScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final intakeCoordinatorClientAssignmentScreenControllerProvider =
    NotifierProvider<
      IntakeCoordinatorClientAssignmentScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IntakeCoordinatorClientAssignmentScreenController();
    });

class IntakeCoordinatorClientAssignmentScreenController
    extends BaseScaffoldController {}
