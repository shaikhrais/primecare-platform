// Governance - Category: controller | Purpose: Non-executable scaffold for TrainerAssignmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainerAssignmentsScreenControllerProvider =
    NotifierProvider<
      TrainerAssignmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainerAssignmentsScreenController();
    });

class TrainerAssignmentsScreenController extends BaseScaffoldController {}
