// Governance - Category: controller | Purpose: Non-executable scaffold for FinanceDirectorCashflowScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final financeDirectorCashflowScreenControllerProvider =
    NotifierProvider<
      FinanceDirectorCashflowScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FinanceDirectorCashflowScreenController();
    });

class FinanceDirectorCashflowScreenController extends BaseScaffoldController {}
