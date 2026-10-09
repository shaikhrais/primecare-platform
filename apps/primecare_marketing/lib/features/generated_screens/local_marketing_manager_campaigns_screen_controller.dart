// Governance - Category: controller | Purpose: Non-executable scaffold for LocalMarketingManagerCampaignsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final localMarketingManagerCampaignsScreenControllerProvider =
    NotifierProvider<
      LocalMarketingManagerCampaignsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LocalMarketingManagerCampaignsScreenController();
    });

class LocalMarketingManagerCampaignsScreenController
    extends BaseScaffoldController {}
