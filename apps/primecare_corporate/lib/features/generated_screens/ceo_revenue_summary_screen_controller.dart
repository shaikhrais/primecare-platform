// Governance - Category: controller | Purpose: Non-executable scaffold for CeoRevenueSummaryScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ceoRevenueSummaryScreenControllerProvider =
    NotifierProvider<
      CeoRevenueSummaryScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoRevenueSummaryScreenController();
    });

class CeoRevenueSummaryScreenController extends BaseScaffoldController {}
