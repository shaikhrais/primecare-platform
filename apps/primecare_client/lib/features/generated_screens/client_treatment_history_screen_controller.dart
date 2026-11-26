// Governance - Category: controller | Purpose: Non-executable scaffold for ClientTreatmentHistoryScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final clientTreatmentHistoryScreenControllerProvider =
    NotifierProvider<
      ClientTreatmentHistoryScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClientTreatmentHistoryScreenController();
    });

class ClientTreatmentHistoryScreenController extends BaseScaffoldController {}
