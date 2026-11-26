// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfMarketingCampaignsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final headOfMarketingCampaignsScreenControllerProvider =
    NotifierProvider<
      HeadOfMarketingCampaignsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfMarketingCampaignsScreenController();
    });

class HeadOfMarketingCampaignsScreenController extends BaseScaffoldController {}
