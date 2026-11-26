// Governance - Category: controller | Purpose: Non-executable scaffold for PswDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final pswDashboardScreenControllerProvider =
    NotifierProvider<
      PswDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswDashboardScreenController();
    });

class PswDashboardScreenController extends BaseScaffoldController {}
