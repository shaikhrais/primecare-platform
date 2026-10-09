// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfMarketingDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final headOfMarketingDashboardScreenControllerProvider =
    NotifierProvider<
      HeadOfMarketingDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfMarketingDashboardScreenController();
    });

class HeadOfMarketingDashboardScreenController extends BaseScaffoldController {}
