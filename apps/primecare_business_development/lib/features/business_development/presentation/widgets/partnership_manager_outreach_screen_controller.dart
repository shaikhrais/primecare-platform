// Governance - Category: controller | Purpose: Non-executable scaffold for PartnershipManagerOutreachScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final partnershipManagerOutreachScreenControllerProvider =
    NotifierProvider<
      PartnershipManagerOutreachScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PartnershipManagerOutreachScreenController();
    });

class PartnershipManagerOutreachScreenController
    extends BaseScaffoldController {}
