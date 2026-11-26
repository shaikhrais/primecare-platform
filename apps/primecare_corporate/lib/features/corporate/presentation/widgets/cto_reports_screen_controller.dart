// Governance - Category: controller | Purpose: Non-executable scaffold for CtoReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final ctoReportsScreenControllerProvider =
    NotifierProvider<
      CtoReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoReportsScreenController();
    });

class CtoReportsScreenController extends BaseScaffoldController {}
