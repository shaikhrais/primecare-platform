// Governance - Category: controller | Purpose: Non-executable scaffold for LocalMarketingManagerBudgetScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final localMarketingManagerBudgetScreenControllerProvider =
    NotifierProvider<
      LocalMarketingManagerBudgetScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LocalMarketingManagerBudgetScreenController();
    });

class LocalMarketingManagerBudgetScreenController
    extends BaseScaffoldController {}
