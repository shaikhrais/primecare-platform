// Governance - Category: controller | Purpose: Non-executable scaffold for ClientPaymentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final clientPaymentsScreenControllerProvider =
    NotifierProvider<
      ClientPaymentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClientPaymentsScreenController();
    });

class ClientPaymentsScreenController extends BaseScaffoldController {}
