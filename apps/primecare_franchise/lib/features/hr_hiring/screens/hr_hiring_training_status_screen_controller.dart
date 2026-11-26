// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringTrainingStatusScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final hrHiringTrainingStatusScreenControllerProvider =
    NotifierProvider<
      HrHiringTrainingStatusScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringTrainingStatusScreenController();
    });

class HrHiringTrainingStatusScreenController extends BaseScaffoldController {}
