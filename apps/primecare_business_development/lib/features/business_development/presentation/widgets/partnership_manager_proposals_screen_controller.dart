// Governance - Category: controller | Purpose: Non-executable scaffold for PartnershipManagerProposalsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final partnershipManagerProposalsScreenControllerProvider =
    NotifierProvider<
      PartnershipManagerProposalsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PartnershipManagerProposalsScreenController();
    });

class PartnershipManagerProposalsScreenController
    extends BaseScaffoldController {}
