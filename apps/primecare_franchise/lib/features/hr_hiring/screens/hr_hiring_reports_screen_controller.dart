// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final hrHiringReportsScreenControllerProvider =
    NotifierProvider<
      HrHiringReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringReportsScreenController();
    });

class HrHiringReportsScreenController extends BaseScaffoldController {}
