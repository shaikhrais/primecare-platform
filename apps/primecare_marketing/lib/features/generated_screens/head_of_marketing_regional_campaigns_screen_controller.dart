// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfMarketingRegionalCampaignsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final headOfMarketingRegionalCampaignsScreenControllerProvider =
    NotifierProvider<
      HeadOfMarketingRegionalCampaignsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfMarketingRegionalCampaignsScreenController();
    });

class HeadOfMarketingRegionalCampaignsScreenController
    extends BaseScaffoldController {}
