// Governance - Category: controller | Purpose: Non-executable scaffold for PartnershipManagerActiveDealsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final partnershipManagerActiveDealsScreenControllerProvider =
    NotifierProvider<
      PartnershipManagerActiveDealsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PartnershipManagerActiveDealsScreenController();
    });

class PartnershipManagerActiveDealsScreenController
    extends BaseScaffoldController {}
