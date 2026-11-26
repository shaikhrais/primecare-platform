// Governance - Category: controller | Purpose: Non-executable scaffold for CooComplianceViewScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cooComplianceViewScreenControllerProvider =
    NotifierProvider<
      CooComplianceViewScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooComplianceViewScreenController();
    });

class CooComplianceViewScreenController extends BaseScaffoldController {}
