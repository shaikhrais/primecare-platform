// Governance - Category: controller | Purpose: Non-executable scaffold for AdminInvoicesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final adminInvoicesScreenControllerProvider =
    NotifierProvider<
      AdminInvoicesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminInvoicesScreenController();
    });

class AdminInvoicesScreenController extends BaseScaffoldController {}
