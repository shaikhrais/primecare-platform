// Governance - Category: controller | Purpose: Non-executable scaffold for CtoDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ctoDashboardScreenControllerProvider =
    NotifierProvider<
      CtoDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoDashboardScreenController();
    });

class CtoDashboardScreenController extends BaseScaffoldController {}
