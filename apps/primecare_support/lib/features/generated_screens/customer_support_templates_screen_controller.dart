// Governance - Category: controller | Purpose: Non-executable scaffold for CustomerSupportTemplatesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final customerSupportTemplatesScreenControllerProvider =
    NotifierProvider<
      CustomerSupportTemplatesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CustomerSupportTemplatesScreenController();
    });

class CustomerSupportTemplatesScreenController extends BaseScaffoldController {}
