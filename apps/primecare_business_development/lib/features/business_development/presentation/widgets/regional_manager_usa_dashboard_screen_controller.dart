// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalManagerUsaDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final regionalManagerUsaDashboardScreenControllerProvider =
    NotifierProvider<
      RegionalManagerUsaDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalManagerUsaDashboardScreenController();
    });

class RegionalManagerUsaDashboardScreenController
    extends BaseScaffoldController {}
