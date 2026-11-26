import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriftFindingsScreenState
    extends DashboardState<DriftFindingsScreenState> {
  DriftFindingsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  DriftFindingsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      DriftFindingsScreenState(isLoading: isLoading, error: error, data: data);
}

class DriftFindingsScreenController
    extends BaseDashboardController<DriftFindingsScreenState> {
  DriftFindingsScreenController(Ref ref)
    : super(
        ref,
        initialState: DriftFindingsScreenState(isLoading: true, data: {}),
        endpoint: '/common/drift-findings',
      );
}

final drift_findingsControllerProvider =
    StateNotifierProvider<
      DriftFindingsScreenController,
      DriftFindingsScreenState
    >((ref) {
      return DriftFindingsScreenController(ref);
    });
