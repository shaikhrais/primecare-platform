// Governance - Category: controller | Purpose: Non-executable scaffold for AdminDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final adminDashboardScreenControllerProvider =
    NotifierProvider<
      AdminDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminDashboardScreenController();
    });

class AdminDashboardScreenController extends BaseScaffoldController {}
