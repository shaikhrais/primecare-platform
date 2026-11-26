// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfMarketingBrandAssetsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final headOfMarketingBrandAssetsScreenControllerProvider =
    NotifierProvider<
      HeadOfMarketingBrandAssetsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfMarketingBrandAssetsScreenController();
    });

class HeadOfMarketingBrandAssetsScreenController
    extends BaseScaffoldController {}
