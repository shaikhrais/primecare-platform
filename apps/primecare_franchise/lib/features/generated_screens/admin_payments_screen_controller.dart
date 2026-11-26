// Governance - Category: controller | Purpose: Non-executable scaffold for AdminPaymentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final adminPaymentsScreenControllerProvider =
    NotifierProvider<
      AdminPaymentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminPaymentsScreenController();
    });

class AdminPaymentsScreenController extends BaseScaffoldController {}
