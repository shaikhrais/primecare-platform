// Governance - Category: controller | Purpose: Non-executable scaffold for UnknownDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final unknownDashboardScreenControllerProvider =
    NotifierProvider<
      UnknownDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return UnknownDashboardScreenController();
    });

class UnknownDashboardScreenController extends BaseScaffoldController {}
