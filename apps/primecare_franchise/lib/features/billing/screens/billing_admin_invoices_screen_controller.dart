// Governance - Category: controller | Purpose: Non-executable scaffold for BillingAdminInvoicesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final billingAdminInvoicesScreenControllerProvider =
    NotifierProvider<
      BillingAdminInvoicesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return BillingAdminInvoicesScreenController();
    });

class BillingAdminInvoicesScreenController extends BaseScaffoldController {}
