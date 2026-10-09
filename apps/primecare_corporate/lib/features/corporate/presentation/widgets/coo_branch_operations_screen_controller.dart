// Governance - Category: controller | Purpose: Non-executable scaffold for CooBranchOperationsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cooBranchOperationsScreenControllerProvider =
    NotifierProvider<
      CooBranchOperationsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooBranchOperationsScreenController();
    });

class CooBranchOperationsScreenController extends BaseScaffoldController {}
