// Governance - Category: controller | Purpose: Non-executable scaffold for CustomerSupportEscalationsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final customerSupportEscalationsScreenControllerProvider =
    NotifierProvider<
      CustomerSupportEscalationsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CustomerSupportEscalationsScreenController();
    });

class CustomerSupportEscalationsScreenController
    extends BaseScaffoldController {}
