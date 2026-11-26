// Governance - Category: controller | Purpose: Non-executable scaffold for CooReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cooReportsScreenControllerProvider =
    NotifierProvider<
      CooReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooReportsScreenController();
    });

class CooReportsScreenController extends BaseScaffoldController {}
