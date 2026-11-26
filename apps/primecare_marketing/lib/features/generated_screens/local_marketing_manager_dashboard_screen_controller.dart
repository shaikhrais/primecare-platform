// Governance - Category: controller | Purpose: Non-executable scaffold for LocalMarketingManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final localMarketingManagerDashboardScreenControllerProvider =
    NotifierProvider<
      LocalMarketingManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LocalMarketingManagerDashboardScreenController();
    });

class LocalMarketingManagerDashboardScreenController
    extends BaseScaffoldController {}
