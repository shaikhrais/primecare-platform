// Governance - Category: controller | Purpose: Non-executable scaffold for OwnerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ownerDashboardScreenControllerProvider =
    NotifierProvider<
      OwnerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return OwnerDashboardScreenController();
    });

class OwnerDashboardScreenController extends BaseScaffoldController {}
