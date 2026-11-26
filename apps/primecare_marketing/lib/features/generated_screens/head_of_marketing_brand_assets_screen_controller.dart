// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfMarketingBrandAssetsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final headOfMarketingBrandAssetsScreenControllerProvider =
    NotifierProvider<
      HeadOfMarketingBrandAssetsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfMarketingBrandAssetsScreenController();
    });

class HeadOfMarketingBrandAssetsScreenController
    extends BaseScaffoldController {}
