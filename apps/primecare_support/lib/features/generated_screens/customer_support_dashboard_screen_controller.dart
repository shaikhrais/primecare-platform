// Governance - Category: controller | Purpose: Non-executable scaffold for CustomerSupportDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final customerSupportDashboardScreenControllerProvider =
    NotifierProvider<
      CustomerSupportDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CustomerSupportDashboardScreenController();
    });

class CustomerSupportDashboardScreenController extends BaseScaffoldController {}
