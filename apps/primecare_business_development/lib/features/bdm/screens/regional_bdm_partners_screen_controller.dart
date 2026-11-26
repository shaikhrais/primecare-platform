// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmPartnersScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalBdmPartnersScreenControllerProvider =
    NotifierProvider<
      RegionalBdmPartnersScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmPartnersScreenController();
    });

class RegionalBdmPartnersScreenController extends BaseScaffoldController {}
