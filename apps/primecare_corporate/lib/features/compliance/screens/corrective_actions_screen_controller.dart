// Governance - Category: controller | Purpose: Non-executable scaffold for CorrectiveActionsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final correctiveActionsScreenControllerProvider =
    NotifierProvider<
      CorrectiveActionsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CorrectiveActionsScreenController();
    });

class CorrectiveActionsScreenController extends BaseScaffoldController {}
