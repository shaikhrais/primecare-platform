// Governance - Category: controller | Purpose: Standalone compile-safe Notifier for ClinicalReferenceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clinicalReferenceScreenControllerProvider = NotifierProvider<ClinicalReferenceScreenController, AsyncValue<Map<String, dynamic>>>(() {
  return ClinicalReferenceScreenController();
});

class ClinicalReferenceScreenController extends Notifier<AsyncValue<Map<String, dynamic>>> {
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
