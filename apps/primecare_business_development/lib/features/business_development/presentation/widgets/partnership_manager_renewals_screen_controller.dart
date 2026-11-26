// Governance - Category: controller | Purpose: Non-executable scaffold for PartnershipManagerRenewalsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final partnershipManagerRenewalsScreenControllerProvider =
    NotifierProvider<
      PartnershipManagerRenewalsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PartnershipManagerRenewalsScreenController();
    });

class PartnershipManagerRenewalsScreenController
    extends BaseScaffoldController {}
