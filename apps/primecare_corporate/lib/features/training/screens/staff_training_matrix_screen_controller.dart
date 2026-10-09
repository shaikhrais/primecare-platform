// Governance - Category: controller | Purpose: Non-executable scaffold for StaffTrainingMatrixScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final staffTrainingMatrixScreenControllerProvider =
    NotifierProvider<
      StaffTrainingMatrixScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return StaffTrainingMatrixScreenController();
    });

class StaffTrainingMatrixScreenController extends BaseScaffoldController {}
