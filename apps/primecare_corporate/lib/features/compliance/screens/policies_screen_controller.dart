// Governance - Category: controller | Purpose: Non-executable scaffold for PoliciesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final policiesScreenControllerProvider =
    NotifierProvider<
      PoliciesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PoliciesScreenController();
    });

class PoliciesScreenController extends BaseScaffoldController {}
