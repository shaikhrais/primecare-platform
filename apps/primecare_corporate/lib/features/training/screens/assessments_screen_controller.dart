// Governance - Category: controller | Purpose: Non-executable scaffold for AssessmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final assessmentsScreenControllerProvider =
    NotifierProvider<
      AssessmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AssessmentsScreenController();
    });

class AssessmentsScreenController extends BaseScaffoldController {}
