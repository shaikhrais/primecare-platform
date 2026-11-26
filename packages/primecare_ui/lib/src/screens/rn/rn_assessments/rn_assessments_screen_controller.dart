import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnAssessmentsScreenState
    extends DashboardState<RnAssessmentsScreenState> {
  RnAssessmentsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnAssessmentsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      RnAssessmentsScreenState(isLoading: isLoading, error: error, data: data);
}

class RnAssessmentsScreenController
    extends BaseDashboardController<RnAssessmentsScreenState> {
  RnAssessmentsScreenController(Ref ref)
    : super(
        ref,
        initialState: RnAssessmentsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/rn-assessments',
      );
}

final rn_assessmentsControllerProvider =
    StateNotifierProvider<
      RnAssessmentsScreenController,
      RnAssessmentsScreenState
    >((ref) {
      return RnAssessmentsScreenController(ref);
    });
