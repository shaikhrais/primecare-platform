// Governance - Category: controller | Purpose: Non-executable scaffold for PartnershipManagerRenewalsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final partnershipManagerRenewalsScreenControllerProvider =
    NotifierProvider<
      PartnershipManagerRenewalsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PartnershipManagerRenewalsScreenController();
    });

class PartnershipManagerRenewalsScreenController
    extends BaseScaffoldController {}
