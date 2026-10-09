// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfMarketingFunnelAnalyticsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final headOfMarketingFunnelAnalyticsScreenControllerProvider =
    NotifierProvider<
      HeadOfMarketingFunnelAnalyticsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfMarketingFunnelAnalyticsScreenController();
    });

class HeadOfMarketingFunnelAnalyticsScreenController
    extends BaseScaffoldController {}
