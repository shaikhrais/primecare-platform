// Governance - Category: controller | Purpose: Non-executable scaffold for CeoDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final ceoDashboardScreenControllerProvider =
    NotifierProvider<
      CeoDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoDashboardScreenController();
    });

class CeoDashboardScreenController extends BaseScaffoldController {}
