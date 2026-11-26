// Governance - Category: controller | Purpose: Non-executable scaffold for CooBranchOperationsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cooBranchOperationsScreenControllerProvider =
    NotifierProvider<
      CooBranchOperationsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooBranchOperationsScreenController();
    });

class CooBranchOperationsScreenController extends BaseScaffoldController {}
