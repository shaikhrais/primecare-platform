import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorHiringPipelineScreenState
    extends DashboardState<HrDirectorHiringPipelineScreenState> {
  HrDirectorHiringPipelineScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrDirectorHiringPipelineScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrDirectorHiringPipelineScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrDirectorHiringPipelineScreenController
    extends BaseDashboardController<HrDirectorHiringPipelineScreenState> {
  HrDirectorHiringPipelineScreenController(Ref ref)
    : super(
        ref,
        initialState: HrDirectorHiringPipelineScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/hr-director-hiring-pipeline',
      );
}

final hr_director_hiring_pipelineControllerProvider =
    StateNotifierProvider<
      HrDirectorHiringPipelineScreenController,
      HrDirectorHiringPipelineScreenState
    >((ref) {
      return HrDirectorHiringPipelineScreenController(ref);
    });
