// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmLeadsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalBdmLeadsScreenControllerProvider =
    NotifierProvider<
      RegionalBdmLeadsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmLeadsScreenController();
    });

class RegionalBdmLeadsScreenController extends BaseScaffoldController {}
