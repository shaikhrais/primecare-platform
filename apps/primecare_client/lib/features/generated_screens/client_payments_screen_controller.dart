// Governance - Category: controller | Purpose: Non-executable scaffold for ClientPaymentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final clientPaymentsScreenControllerProvider =
    NotifierProvider<
      ClientPaymentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClientPaymentsScreenController();
    });

class ClientPaymentsScreenController extends BaseScaffoldController {}
