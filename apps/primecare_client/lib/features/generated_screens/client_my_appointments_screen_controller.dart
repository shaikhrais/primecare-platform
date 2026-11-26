// Governance - Category: controller | Purpose: Non-executable scaffold for ClientMyAppointmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final clientMyAppointmentsScreenControllerProvider =
    NotifierProvider<
      ClientMyAppointmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClientMyAppointmentsScreenController();
    });

class ClientMyAppointmentsScreenController extends BaseScaffoldController {}
