// Governance - Category: controller | Purpose: Non-executable scaffold for TrainerAssignmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainerAssignmentsScreenControllerProvider =
    NotifierProvider<
      TrainerAssignmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainerAssignmentsScreenController();
    });

class TrainerAssignmentsScreenController extends BaseScaffoldController {}
