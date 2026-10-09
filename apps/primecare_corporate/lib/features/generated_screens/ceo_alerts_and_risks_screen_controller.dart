// Governance - Category: controller | Purpose: Non-executable scaffold for CeoAlertsAndRisksScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ceoAlertsAndRisksScreenControllerProvider =
    NotifierProvider<
      CeoAlertsAndRisksScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoAlertsAndRisksScreenController();
    });

class CeoAlertsAndRisksScreenController extends BaseScaffoldController {}
