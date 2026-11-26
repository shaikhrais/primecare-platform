// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyMemberDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final familyMemberDashboardScreenControllerProvider =
    NotifierProvider<
      FamilyMemberDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyMemberDashboardScreenController();
    });

class FamilyMemberDashboardScreenController extends BaseScaffoldController {}
