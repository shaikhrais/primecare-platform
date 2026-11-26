// Governance - Category: controller | Purpose: Non-executable scaffold for IntakeCoordinatorReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final intakeCoordinatorReportsScreenControllerProvider =
    NotifierProvider<
      IntakeCoordinatorReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IntakeCoordinatorReportsScreenController();
    });

class IntakeCoordinatorReportsScreenController extends BaseScaffoldController {}
