// Governance - Category: controller | Purpose: Non-executable scaffold for MarketingManagerCampaignsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final marketingManagerCampaignsScreenControllerProvider =
    NotifierProvider<
      MarketingManagerCampaignsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return MarketingManagerCampaignsScreenController();
    });

class MarketingManagerCampaignsScreenController
    extends BaseScaffoldController {}
