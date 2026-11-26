// Governance - Category: controller | Purpose: Non-executable scaffold for CooDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cooDashboardScreenControllerProvider =
    NotifierProvider<
      CooDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooDashboardScreenController();
    });

class CooDashboardScreenController extends BaseScaffoldController {}
