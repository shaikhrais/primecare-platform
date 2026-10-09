// Governance - Category: controller | Purpose: Non-executable scaffold for AuditsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final auditsScreenControllerProvider =
    NotifierProvider<AuditsScreenController, AsyncValue<Map<String, dynamic>>>(
      () {
        return AuditsScreenController();
      },
    );

class AuditsScreenController extends BaseScaffoldController {}
