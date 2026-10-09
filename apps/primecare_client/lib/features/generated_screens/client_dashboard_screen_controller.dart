// Governance - Category: controller | Purpose: Non-executable scaffold for ClientDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final clientDashboardScreenControllerProvider =
    NotifierProvider<
      ClientDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClientDashboardScreenController();
    });

class ClientDashboardScreenController extends BaseScaffoldController {}
