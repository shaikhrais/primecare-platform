// Governance - Category: controller | Purpose: Non-executable scaffold for ClientDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final clientDashboardScreenControllerProvider =
    NotifierProvider<
      ClientDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClientDashboardScreenController();
    });

class ClientDashboardScreenController extends BaseScaffoldController {}
