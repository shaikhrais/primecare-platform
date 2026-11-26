// Governance - Category: controller | Purpose: Non-executable scaffold for CfoRevenueScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cfoRevenueScreenControllerProvider =
    NotifierProvider<
      CfoRevenueScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoRevenueScreenController();
    });

class CfoRevenueScreenController extends BaseScaffoldController {}
