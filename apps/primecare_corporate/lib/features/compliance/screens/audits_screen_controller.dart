// Governance - Category: controller | Purpose: Non-executable scaffold for AuditsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final auditsScreenControllerProvider =
    NotifierProvider<AuditsScreenController, AsyncValue<Map<String, dynamic>>>(
      () {
        return AuditsScreenController();
      },
    );

class AuditsScreenController extends BaseScaffoldController {}
