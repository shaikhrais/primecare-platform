import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnCarePlanReviewScreenState
    extends DashboardState<RnCarePlanReviewScreenState> {
  RnCarePlanReviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnCarePlanReviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnCarePlanReviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RnCarePlanReviewScreenController
    extends BaseDashboardController<RnCarePlanReviewScreenState> {
  RnCarePlanReviewScreenController(Ref ref)
    : super(
        ref,
        initialState: RnCarePlanReviewScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/rn-care-plan-review',
      );
}

final rn_care_plan_reviewControllerProvider =
    StateNotifierProvider<
      RnCarePlanReviewScreenController,
      RnCarePlanReviewScreenState
    >((ref) {
      return RnCarePlanReviewScreenController(ref);
    });
