// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final regionalBdmReportsScreenControllerProvider =
    NotifierProvider<
      RegionalBdmReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmReportsScreenController();
    });

class RegionalBdmReportsScreenController extends BaseScaffoldController {}
