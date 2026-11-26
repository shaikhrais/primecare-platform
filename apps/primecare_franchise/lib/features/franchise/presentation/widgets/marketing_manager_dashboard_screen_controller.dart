// Governance - Category: controller | Purpose: Non-executable scaffold for MarketingManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final marketingManagerDashboardScreenControllerProvider =
    NotifierProvider<
      MarketingManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return MarketingManagerDashboardScreenController();
    });

class MarketingManagerDashboardScreenController
    extends BaseScaffoldController {}
