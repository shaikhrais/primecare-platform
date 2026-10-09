// Governance - Category: controller | Purpose: Non-executable scaffold for HeadOfBusDevDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final headOfBusDevDashboardScreenControllerProvider =
    NotifierProvider<
      HeadOfBusDevDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HeadOfBusDevDashboardScreenController();
    });

class HeadOfBusDevDashboardScreenController extends BaseScaffoldController {}
