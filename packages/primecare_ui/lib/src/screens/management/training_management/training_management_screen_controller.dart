import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingManagementScreenState
    extends DashboardState<TrainingManagementScreenState> {
  TrainingManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingManagementScreenController
    extends BaseDashboardController<TrainingManagementScreenState> {
  TrainingManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingManagementScreenState(isLoading: true, data: {}),
        endpoint: '/management/training-management',
      );
}

final training_managementControllerProvider =
    StateNotifierProvider<
      TrainingManagementScreenController,
      TrainingManagementScreenState
    >((ref) {
      return TrainingManagementScreenController(ref);
    });
