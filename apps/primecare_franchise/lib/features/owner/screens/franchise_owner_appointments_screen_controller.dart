// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerAppointmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final franchiseOwnerAppointmentsScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerAppointmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerAppointmentsScreenController();
    });

class FranchiseOwnerAppointmentsScreenController
    extends BaseScaffoldController {}
