// Governance - Category: controller | Purpose: Non-executable scaffold for CustomerSupportIssueCategoriesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final customerSupportIssueCategoriesScreenControllerProvider =
    NotifierProvider<
      CustomerSupportIssueCategoriesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CustomerSupportIssueCategoriesScreenController();
    });

class CustomerSupportIssueCategoriesScreenController
    extends BaseScaffoldController {}
