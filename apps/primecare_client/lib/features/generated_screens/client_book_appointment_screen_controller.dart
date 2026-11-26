// Governance - Category: controller | Purpose: Non-executable scaffold for ClientBookAppointmentScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final clientBookAppointmentScreenControllerProvider =
    NotifierProvider<
      ClientBookAppointmentScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClientBookAppointmentScreenController();
    });

class ClientBookAppointmentScreenController extends BaseScaffoldController {}
