// Governance - Category: controller | Purpose: Standalone compile-safe Notifier for ClinicIncidentReportScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clinicIncidentReportScreenControllerProvider = NotifierProvider<ClinicIncidentReportScreenController, AsyncValue<Map<String, dynamic>>>(() {
  return ClinicIncidentReportScreenController();
});

class ClinicIncidentReportScreenController extends Notifier<AsyncValue<Map<String, dynamic>>> {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    _init();
    return const AsyncValue.data({});
  }

  Future<void> _init() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    state = const AsyncValue.data({
      'status': 'success',
      'featuresEnabled': true,
      'dataLoaded': true,
    });
  }

  Future<void> performAction() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return {'status': 'action_completed'};
    });
  }
}
