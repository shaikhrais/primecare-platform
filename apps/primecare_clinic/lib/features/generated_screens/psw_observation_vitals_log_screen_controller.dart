// Governance - Category: controller | Purpose: Non-executable scaffold for PswObservationVitalsLogScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final pswObservationVitalsLogScreenControllerProvider =
    NotifierProvider<
      PswObservationVitalsLogScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswObservationVitalsLogScreenController();
    });

class PswObservationVitalsLogScreenController extends BaseScaffoldController {}
