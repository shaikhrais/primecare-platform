import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hr_hiring_onboarding_screen_controller_controller.g.dart';

@riverpod
class HrHiringOnboardingScreenControllerController extends _$HrHiringOnboardingScreenControllerController {
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
