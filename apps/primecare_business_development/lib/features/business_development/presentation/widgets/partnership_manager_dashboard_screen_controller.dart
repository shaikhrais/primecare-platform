// Governance - Category: controller | Purpose: Non-executable scaffold for PartnershipManagerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final partnershipManagerDashboardScreenControllerProvider =
    NotifierProvider<
      PartnershipManagerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PartnershipManagerDashboardScreenController();
    });

class PartnershipManagerDashboardScreenController
    extends BaseScaffoldController {}
