import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RuntimeVerificationScreenState
    extends DashboardState<RuntimeVerificationScreenState> {
  RuntimeVerificationScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RuntimeVerificationScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RuntimeVerificationScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RuntimeVerificationScreenController
    extends BaseDashboardController<RuntimeVerificationScreenState> {
  RuntimeVerificationScreenController(Ref ref)
    : super(
        ref,
        initialState: RuntimeVerificationScreenState(isLoading: true, data: {}),
        endpoint: '/common/runtime-verification',
      );
}

final runtime_verificationControllerProvider =
    StateNotifierProvider<
      RuntimeVerificationScreenController,
      RuntimeVerificationScreenState
    >((ref) {
      return RuntimeVerificationScreenController(ref);
    });
