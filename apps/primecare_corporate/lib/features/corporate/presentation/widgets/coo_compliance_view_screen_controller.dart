// Governance - Category: controller | Purpose: Non-executable scaffold for CooComplianceViewScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cooComplianceViewScreenControllerProvider =
    NotifierProvider<
      CooComplianceViewScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooComplianceViewScreenController();
    });

class CooComplianceViewScreenController extends BaseScaffoldController {}
