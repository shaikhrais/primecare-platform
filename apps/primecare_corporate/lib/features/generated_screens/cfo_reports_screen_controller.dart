// Governance - Category: controller | Purpose: Non-executable scaffold for CfoReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cfoReportsScreenControllerProvider =
    NotifierProvider<
      CfoReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoReportsScreenController();
    });

class CfoReportsScreenController extends BaseScaffoldController {}
