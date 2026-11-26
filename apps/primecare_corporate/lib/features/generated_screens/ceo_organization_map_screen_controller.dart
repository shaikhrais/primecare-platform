// Governance - Category: controller | Purpose: Non-executable scaffold for CeoOrganizationMapScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ceoOrganizationMapScreenControllerProvider =
    NotifierProvider<
      CeoOrganizationMapScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoOrganizationMapScreenController();
    });

class CeoOrganizationMapScreenController extends BaseScaffoldController {}
