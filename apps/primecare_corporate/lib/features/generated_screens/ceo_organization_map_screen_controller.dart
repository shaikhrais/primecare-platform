// Governance - Category: controller | Purpose: Non-executable scaffold for CeoOrganizationMapScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final ceoOrganizationMapScreenControllerProvider =
    NotifierProvider<
      CeoOrganizationMapScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoOrganizationMapScreenController();
    });

class CeoOrganizationMapScreenController extends BaseScaffoldController {}
