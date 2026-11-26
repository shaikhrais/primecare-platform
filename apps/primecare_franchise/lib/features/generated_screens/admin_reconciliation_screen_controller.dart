// Governance - Category: controller | Purpose: Non-executable scaffold for AdminReconciliationScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final adminReconciliationScreenControllerProvider =
    NotifierProvider<
      AdminReconciliationScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminReconciliationScreenController();
    });

class AdminReconciliationScreenController extends BaseScaffoldController {}
