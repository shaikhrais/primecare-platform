// Governance - Category: controller | Purpose: Non-executable scaffold for CeoStrategicKpisScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ceoStrategicKpisScreenControllerProvider =
    NotifierProvider<
      CeoStrategicKpisScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoStrategicKpisScreenController();
    });

class CeoStrategicKpisScreenController extends BaseScaffoldController {}
