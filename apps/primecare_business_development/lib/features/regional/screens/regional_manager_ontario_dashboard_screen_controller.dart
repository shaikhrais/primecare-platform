// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalManagerOntarioDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalManagerOntarioDashboardScreenControllerProvider =
    NotifierProvider<
      RegionalManagerOntarioDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalManagerOntarioDashboardScreenController();
    });

class RegionalManagerOntarioDashboardScreenController
    extends BaseScaffoldController {}
