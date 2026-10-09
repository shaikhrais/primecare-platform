// Governance - Category: controller | Purpose: Non-executable scaffold for LocalMarketingManagerAssetsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final localMarketingManagerAssetsScreenControllerProvider =
    NotifierProvider<
      LocalMarketingManagerAssetsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LocalMarketingManagerAssetsScreenController();
    });

class LocalMarketingManagerAssetsScreenController
    extends BaseScaffoldController {}
