import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CorrectiveActionScreenState
    extends DashboardState<CorrectiveActionScreenState> {
  CorrectiveActionScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CorrectiveActionScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CorrectiveActionScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CorrectiveActionScreenController
    extends BaseDashboardController<CorrectiveActionScreenState> {
  CorrectiveActionScreenController(Ref ref)
    : super(
        ref,
        initialState: CorrectiveActionScreenState(isLoading: true, data: {}),
        endpoint: '/management/corrective-action',
      );
}

final corrective_actionControllerProvider =
    StateNotifierProvider<
      CorrectiveActionScreenController,
      CorrectiveActionScreenState
    >((ref) {
      return CorrectiveActionScreenController(ref);
    });
