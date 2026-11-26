import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClaimsProcessingScreenState
    extends DashboardState<ClaimsProcessingScreenState> {
  ClaimsProcessingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClaimsProcessingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClaimsProcessingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClaimsProcessingScreenController
    extends BaseDashboardController<ClaimsProcessingScreenState> {
  ClaimsProcessingScreenController(Ref ref)
    : super(
        ref,
        initialState: ClaimsProcessingScreenState(isLoading: true, data: {}),
        endpoint: '/staff/claims-processing',
      );
}

final claims_processingControllerProvider =
    StateNotifierProvider<
      ClaimsProcessingScreenController,
      ClaimsProcessingScreenState
    >((ref) {
      return ClaimsProcessingScreenController(ref);
    });
