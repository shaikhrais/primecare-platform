// Governance - Category: controller | Purpose: Non-executable scaffold for OperationsManagerServiceQualityScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final operationsManagerServiceQualityScreenControllerProvider =
    NotifierProvider<
      OperationsManagerServiceQualityScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return OperationsManagerServiceQualityScreenController();
    });

class OperationsManagerServiceQualityScreenController
    extends BaseScaffoldController {}
