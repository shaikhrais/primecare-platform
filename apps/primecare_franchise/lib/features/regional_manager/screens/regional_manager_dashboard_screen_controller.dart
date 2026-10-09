// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalManagerDashboardScreenControllerProvider =
    NotifierProvider<
      RegionalManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalManagerDashboardScreenController();
    });

class RegionalManagerDashboardScreenController extends BaseScaffoldController {}
