// Governance - Category: controller | Purpose: Non-executable scaffold for CfoExpensesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cfoExpensesScreenControllerProvider =
    NotifierProvider<
      CfoExpensesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoExpensesScreenController();
    });

class CfoExpensesScreenController extends BaseScaffoldController {}
