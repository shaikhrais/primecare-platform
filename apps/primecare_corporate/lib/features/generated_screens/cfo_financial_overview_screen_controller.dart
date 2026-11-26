// Governance - Category: controller | Purpose: Non-executable scaffold for CfoFinancialOverviewScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cfoFinancialOverviewScreenControllerProvider =
    NotifierProvider<
      CfoFinancialOverviewScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoFinancialOverviewScreenController();
    });

class CfoFinancialOverviewScreenController extends BaseScaffoldController {}
