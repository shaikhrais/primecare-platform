// Governance - Category: controller | Purpose: Non-executable scaffold for LegalDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final legalDashboardScreenControllerProvider =
    NotifierProvider<
      LegalDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LegalDashboardScreenController();
    });

class LegalDashboardScreenController extends BaseScaffoldController {}
