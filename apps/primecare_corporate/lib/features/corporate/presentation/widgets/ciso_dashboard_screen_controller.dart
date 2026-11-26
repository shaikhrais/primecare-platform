// Governance - Category: controller | Purpose: Non-executable scaffold for CisoDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cisoDashboardScreenControllerProvider =
    NotifierProvider<
      CisoDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CisoDashboardScreenController();
    });

class CisoDashboardScreenController extends BaseScaffoldController {}
