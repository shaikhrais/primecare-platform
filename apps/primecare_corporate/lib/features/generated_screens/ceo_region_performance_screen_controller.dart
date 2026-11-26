// Governance - Category: controller | Purpose: Non-executable scaffold for CeoRegionPerformanceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ceoRegionPerformanceScreenControllerProvider =
    NotifierProvider<
      CeoRegionPerformanceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoRegionPerformanceScreenController();
    });

class CeoRegionPerformanceScreenController extends BaseScaffoldController {}
