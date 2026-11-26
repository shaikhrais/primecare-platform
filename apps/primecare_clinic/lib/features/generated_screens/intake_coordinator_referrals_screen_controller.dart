// Governance - Category: controller | Purpose: Non-executable scaffold for IntakeCoordinatorReferralsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final intakeCoordinatorReferralsScreenControllerProvider =
    NotifierProvider<
      IntakeCoordinatorReferralsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return IntakeCoordinatorReferralsScreenController();
    });

class IntakeCoordinatorReferralsScreenController
    extends BaseScaffoldController {}
