// Governance - Category: controller | Purpose: Non-executable scaffold for CfoProfitabilityScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cfoProfitabilityScreenControllerProvider =
    NotifierProvider<
      CfoProfitabilityScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoProfitabilityScreenController();
    });

class CfoProfitabilityScreenController extends BaseScaffoldController {}
