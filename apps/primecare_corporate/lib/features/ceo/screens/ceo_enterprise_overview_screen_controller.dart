// Governance - Category: controller | Purpose: Non-executable scaffold for CeoEnterpriseOverviewScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ceoEnterpriseOverviewScreenControllerProvider =
    NotifierProvider<
      CeoEnterpriseOverviewScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoEnterpriseOverviewScreenController();
    });

class CeoEnterpriseOverviewScreenController extends BaseScaffoldController {}
