// Governance - Category: controller | Purpose: Non-executable scaffold for CustomerSupportReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final customerSupportReportsScreenControllerProvider =
    NotifierProvider<
      CustomerSupportReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CustomerSupportReportsScreenController();
    });

class CustomerSupportReportsScreenController extends BaseScaffoldController {}
