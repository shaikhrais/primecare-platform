// Governance - Category: controller | Purpose: Non-executable scaffold for CtoPlatformUsageScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ctoPlatformUsageScreenControllerProvider =
    NotifierProvider<
      CtoPlatformUsageScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoPlatformUsageScreenController();
    });

class CtoPlatformUsageScreenController extends BaseScaffoldController {}
