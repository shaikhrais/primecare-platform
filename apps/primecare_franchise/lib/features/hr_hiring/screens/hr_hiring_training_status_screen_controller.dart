// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringTrainingStatusScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final hrHiringTrainingStatusScreenControllerProvider =
    NotifierProvider<
      HrHiringTrainingStatusScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringTrainingStatusScreenController();
    });

class HrHiringTrainingStatusScreenController extends BaseScaffoldController {}
