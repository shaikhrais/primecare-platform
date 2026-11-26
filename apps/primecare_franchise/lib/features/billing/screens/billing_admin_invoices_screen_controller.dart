// Governance - Category: controller | Purpose: Non-executable scaffold for BillingAdminInvoicesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final billingAdminInvoicesScreenControllerProvider =
    NotifierProvider<
      BillingAdminInvoicesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return BillingAdminInvoicesScreenController();
    });

class BillingAdminInvoicesScreenController extends BaseScaffoldController {}
