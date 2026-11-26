import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HiringPipelineScreenState
    extends DashboardState<HiringPipelineScreenState> {
  HiringPipelineScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HiringPipelineScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      HiringPipelineScreenState(isLoading: isLoading, error: error, data: data);
}

class HiringPipelineScreenController
    extends BaseDashboardController<HiringPipelineScreenState> {
  HiringPipelineScreenController(Ref ref)
    : super(
        ref,
        initialState: HiringPipelineScreenState(isLoading: true, data: {}),
        endpoint: '/management/hiring-pipeline',
      );
}

final hiring_pipelineControllerProvider =
    StateNotifierProvider<
      HiringPipelineScreenController,
      HiringPipelineScreenState
    >((ref) {
      return HiringPipelineScreenController(ref);
    });
