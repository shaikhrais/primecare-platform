// Governance - Category: controller | Purpose: Non-executable scaffold for CxDirectorDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cxDirectorDashboardScreenControllerProvider =
    NotifierProvider<
      CxDirectorDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CxDirectorDashboardScreenController();
    });

class CxDirectorDashboardScreenController extends BaseScaffoldController {}
