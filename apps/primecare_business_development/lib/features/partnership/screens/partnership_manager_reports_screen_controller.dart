// Governance - Category: controller | Purpose: Non-executable scaffold for PartnershipManagerReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final partnershipManagerReportsScreenControllerProvider =
    NotifierProvider<
      PartnershipManagerReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PartnershipManagerReportsScreenController();
    });

class PartnershipManagerReportsScreenController
    extends BaseScaffoldController {}
