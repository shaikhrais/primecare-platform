// Governance - Category: controller | Purpose: Non-executable scaffold for CooWorkflowPerformanceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cooWorkflowPerformanceScreenControllerProvider =
    NotifierProvider<
      CooWorkflowPerformanceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooWorkflowPerformanceScreenController();
    });

class CooWorkflowPerformanceScreenController extends BaseScaffoldController {}
