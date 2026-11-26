// Governance - Category: controller | Purpose: Non-executable scaffold for CfoDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cfoDashboardScreenControllerProvider =
    NotifierProvider<
      CfoDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoDashboardScreenController();
    });

class CfoDashboardScreenController extends BaseScaffoldController {}
