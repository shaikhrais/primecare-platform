// Governance - Category: controller | Purpose: Non-executable scaffold for FranchiseOwnerAppointmentsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final franchiseOwnerAppointmentsScreenControllerProvider =
    NotifierProvider<
      FranchiseOwnerAppointmentsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FranchiseOwnerAppointmentsScreenController();
    });

class FranchiseOwnerAppointmentsScreenController
    extends BaseScaffoldController {}
