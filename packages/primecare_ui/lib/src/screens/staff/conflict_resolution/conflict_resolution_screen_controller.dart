import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConflictResolutionScreenState
    extends DashboardState<ConflictResolutionScreenState> {
  ConflictResolutionScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ConflictResolutionScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ConflictResolutionScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ConflictResolutionScreenController
    extends BaseDashboardController<ConflictResolutionScreenState> {
  ConflictResolutionScreenController(Ref ref)
    : super(
        ref,
        initialState: ConflictResolutionScreenState(isLoading: true, data: {}),
        endpoint: '/staff/conflict-resolution',
      );
}

final conflict_resolutionControllerProvider =
    StateNotifierProvider<
      ConflictResolutionScreenController,
      ConflictResolutionScreenState
    >((ref) {
      return ConflictResolutionScreenController(ref);
    });
