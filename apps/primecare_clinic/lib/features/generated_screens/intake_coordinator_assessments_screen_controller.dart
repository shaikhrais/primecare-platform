// Governance - Category: controller | Purpose: Non-executable scaffold for IntakeCoordinatorAssessmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final intakeCoordinatorAssessmentsScreenControllerProvider =
    NotifierProvider<
      IntakeCoordinatorAssessmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IntakeCoordinatorAssessmentsScreenController();
    });

class IntakeCoordinatorAssessmentsScreenController
    extends BaseScaffoldController {}
