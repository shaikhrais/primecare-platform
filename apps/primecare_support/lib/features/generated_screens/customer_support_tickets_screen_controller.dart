// Governance - Category: controller | Purpose: Non-executable scaffold for CustomerSupportTicketsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final customerSupportTicketsScreenControllerProvider =
    NotifierProvider<
      CustomerSupportTicketsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CustomerSupportTicketsScreenController();
    });

class CustomerSupportTicketsScreenController extends BaseScaffoldController {}
