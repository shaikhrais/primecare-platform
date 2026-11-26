// Governance - Category: controller | Purpose: Non-executable scaffold for LocalMarketingManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final localMarketingManagerDashboardScreenControllerProvider =
    NotifierProvider<
      LocalMarketingManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LocalMarketingManagerDashboardScreenController();
    });

class LocalMarketingManagerDashboardScreenController
    extends BaseScaffoldController {}
