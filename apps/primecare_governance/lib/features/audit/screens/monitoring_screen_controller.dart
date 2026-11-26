// Governance - Category: controller | Purpose: Non-executable scaffold for MonitoringScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final monitoringScreenControllerProvider =
    NotifierProvider<
      MonitoringScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return MonitoringScreenController();
    });

class MonitoringScreenController extends BaseScaffoldController {}
