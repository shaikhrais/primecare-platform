// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingCoordinatorAttendanceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingCoordinatorAttendanceScreenControllerProvider =
    NotifierProvider<
      TrainingCoordinatorAttendanceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingCoordinatorAttendanceScreenController();
    });

class TrainingCoordinatorAttendanceScreenController
    extends BaseScaffoldController {}
