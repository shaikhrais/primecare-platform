// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfMarketingCampaignsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final headOfMarketingCampaignsScreenControllerProvider =
    NotifierProvider<
      HeadOfMarketingCampaignsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfMarketingCampaignsScreenController();
    });

class HeadOfMarketingCampaignsScreenController extends BaseScaffoldController {}
