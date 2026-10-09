// Governance - Category: controller | Purpose: Non-executable scaffold for CtoIntegrationsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ctoIntegrationsScreenControllerProvider =
    NotifierProvider<
      CtoIntegrationsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoIntegrationsScreenController();
    });

class CtoIntegrationsScreenController extends BaseScaffoldController {}
