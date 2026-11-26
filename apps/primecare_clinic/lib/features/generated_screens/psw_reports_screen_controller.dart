// Governance - Category: controller | Purpose: Non-executable scaffold for PswReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final pswReportsScreenControllerProvider =
    NotifierProvider<
      PswReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswReportsScreenController();
    });

class PswReportsScreenController extends BaseScaffoldController {}
