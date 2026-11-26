// Governance - Category: controller | Purpose: Non-executable scaffold for CeoDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ceoDashboardScreenControllerProvider =
    NotifierProvider<
      CeoDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoDashboardScreenController();
    });

class CeoDashboardScreenController extends BaseScaffoldController {}
