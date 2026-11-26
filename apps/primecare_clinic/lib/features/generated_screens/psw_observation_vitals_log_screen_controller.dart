// Governance - Category: controller | Purpose: Non-executable scaffold for PswObservationVitalsLogScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final pswObservationVitalsLogScreenControllerProvider =
    NotifierProvider<
      PswObservationVitalsLogScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswObservationVitalsLogScreenController();
    });

class PswObservationVitalsLogScreenController extends BaseScaffoldController {}
