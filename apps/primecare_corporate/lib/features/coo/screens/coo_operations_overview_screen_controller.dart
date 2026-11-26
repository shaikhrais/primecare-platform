// Governance - Category: controller | Purpose: Non-executable scaffold for CooOperationsOverviewScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cooOperationsOverviewScreenControllerProvider =
    NotifierProvider<
      CooOperationsOverviewScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooOperationsOverviewScreenController();
    });

class CooOperationsOverviewScreenController extends BaseScaffoldController {}
