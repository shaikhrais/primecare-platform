// Governance - Category: controller | Purpose: Non-executable scaffold for CfoPayrollScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cfoPayrollScreenControllerProvider =
    NotifierProvider<
      CfoPayrollScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoPayrollScreenController();
    });

class CfoPayrollScreenController extends BaseScaffoldController {}
