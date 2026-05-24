import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clinic_history_logs_screen_controller_controller.g.dart';

@riverpod
class ClinicHistoryLogsScreenControllerController extends _$ClinicHistoryLogsScreenControllerController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    // Generated backend logic hook
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'status': 'success',
      'featuresEnabled': true,
      'dataLoaded': true,
    };
  }

  Future<void> performAction() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(milliseconds: 800));
      return {'status': 'action_completed'};
    });
  }
}
