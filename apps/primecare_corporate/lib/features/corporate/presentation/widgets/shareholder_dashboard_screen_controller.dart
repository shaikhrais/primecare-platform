// Governance - Category: controller | Purpose: Non-executable scaffold for ShareholderDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final shareholderDashboardScreenControllerProvider =
    NotifierProvider<
      ShareholderDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ShareholderDashboardScreenController();
    });

class ShareholderDashboardScreenController extends BaseScaffoldController {}
