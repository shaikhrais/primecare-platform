// Governance - Category: controller | Purpose: Non-executable scaffold for PartnershipManagerPartnersScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final partnershipManagerPartnersScreenControllerProvider =
    NotifierProvider<
      PartnershipManagerPartnersScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PartnershipManagerPartnersScreenController();
    });

class PartnershipManagerPartnersScreenController
    extends BaseScaffoldController {}
