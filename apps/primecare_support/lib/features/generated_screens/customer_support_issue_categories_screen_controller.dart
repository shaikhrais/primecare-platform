// Governance - Category: controller | Purpose: Non-executable scaffold for CustomerSupportIssueCategoriesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final customerSupportIssueCategoriesScreenControllerProvider =
    NotifierProvider<
      CustomerSupportIssueCategoriesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CustomerSupportIssueCategoriesScreenController();
    });

class CustomerSupportIssueCategoriesScreenController
    extends BaseScaffoldController {}
