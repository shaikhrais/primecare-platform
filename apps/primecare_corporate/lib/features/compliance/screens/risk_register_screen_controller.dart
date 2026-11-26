// Governance - Category: controller | Purpose: Non-executable scaffold for RiskRegisterScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final riskRegisterScreenControllerProvider =
    NotifierProvider<
      RiskRegisterScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RiskRegisterScreenController();
    });

class RiskRegisterScreenController extends BaseScaffoldController {}
