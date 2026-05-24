import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'infection_control_dashboard_screen_controller_controller.g.dart';

@riverpod
class InfectionControlDashboardScreenControllerController extends _$InfectionControlDashboardScreenControllerController {
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
