// Governance - Category: controller | Purpose: Non-executable scaffold for ClientBookAppointmentScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final clientBookAppointmentScreenControllerProvider =
    NotifierProvider<
      ClientBookAppointmentScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClientBookAppointmentScreenController();
    });

class ClientBookAppointmentScreenController extends BaseScaffoldController {}
