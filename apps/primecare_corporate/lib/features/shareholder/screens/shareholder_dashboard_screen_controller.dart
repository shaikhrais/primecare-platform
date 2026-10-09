// Governance - Category: controller | Purpose: Non-executable scaffold for ShareholderDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final shareholderDashboardScreenControllerProvider =
    NotifierProvider<
      ShareholderDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ShareholderDashboardScreenController();
    });

class ShareholderDashboardScreenController extends BaseScaffoldController {}
