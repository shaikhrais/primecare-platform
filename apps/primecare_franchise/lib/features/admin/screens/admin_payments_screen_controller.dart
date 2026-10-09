// Governance - Category: controller | Purpose: Non-executable scaffold for AdminPaymentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final adminPaymentsScreenControllerProvider =
    NotifierProvider<
      AdminPaymentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminPaymentsScreenController();
    });

class AdminPaymentsScreenController extends BaseScaffoldController {}
