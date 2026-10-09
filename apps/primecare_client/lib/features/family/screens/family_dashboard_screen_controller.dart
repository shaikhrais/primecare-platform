// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final familyDashboardScreenControllerProvider =
    NotifierProvider<
      FamilyDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyDashboardScreenController();
    });

class FamilyDashboardScreenController extends BaseScaffoldController {}
