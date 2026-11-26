// Governance - Category: controller | Purpose: Non-executable scaffold for CeoFranchiseOverviewScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ceoFranchiseOverviewScreenControllerProvider =
    NotifierProvider<
      CeoFranchiseOverviewScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoFranchiseOverviewScreenController();
    });

class CeoFranchiseOverviewScreenController extends BaseScaffoldController {}
