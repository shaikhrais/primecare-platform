// Governance - Category: controller | Purpose: Non-executable scaffold for CtoApiMonitoringScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ctoApiMonitoringScreenControllerProvider =
    NotifierProvider<
      CtoApiMonitoringScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoApiMonitoringScreenController();
    });

class CtoApiMonitoringScreenController extends BaseScaffoldController {}
