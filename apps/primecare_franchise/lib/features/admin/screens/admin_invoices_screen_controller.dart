// Governance - Category: controller | Purpose: Non-executable scaffold for AdminInvoicesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final adminInvoicesScreenControllerProvider =
    NotifierProvider<
      AdminInvoicesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminInvoicesScreenController();
    });

class AdminInvoicesScreenController extends BaseScaffoldController {}
