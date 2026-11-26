// Governance - Category: controller | Purpose: Non-executable scaffold for CustomerSupportTemplatesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final customerSupportTemplatesScreenControllerProvider =
    NotifierProvider<
      CustomerSupportTemplatesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CustomerSupportTemplatesScreenController();
    });

class CustomerSupportTemplatesScreenController extends BaseScaffoldController {}
