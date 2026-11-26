import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorTrainingScreenState
    extends DashboardState<HrDirectorTrainingScreenState> {
  HrDirectorTrainingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrDirectorTrainingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrDirectorTrainingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrDirectorTrainingScreenController
    extends BaseDashboardController<HrDirectorTrainingScreenState> {
  HrDirectorTrainingScreenController(Ref ref)
    : super(
        ref,
        initialState: HrDirectorTrainingScreenState(isLoading: true, data: {}),
        endpoint: '/executive/hr-director-training',
      );
}

final hr_director_trainingControllerProvider =
    StateNotifierProvider<
      HrDirectorTrainingScreenController,
      HrDirectorTrainingScreenState
    >((ref) {
      return HrDirectorTrainingScreenController(ref);
    });
