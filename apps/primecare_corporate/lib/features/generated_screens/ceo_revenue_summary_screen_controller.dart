// Governance - Category: controller | Purpose: Non-executable scaffold for CeoRevenueSummaryScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final ceoRevenueSummaryScreenControllerProvider =
    NotifierProvider<
      CeoRevenueSummaryScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoRevenueSummaryScreenController();
    });

class CeoRevenueSummaryScreenController extends BaseScaffoldController {}
