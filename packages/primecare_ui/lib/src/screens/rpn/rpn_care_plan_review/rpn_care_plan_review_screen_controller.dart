import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnCarePlanReviewScreenState
    extends DashboardState<RpnCarePlanReviewScreenState> {
  RpnCarePlanReviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnCarePlanReviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RpnCarePlanReviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RpnCarePlanReviewScreenController
    extends BaseDashboardController<RpnCarePlanReviewScreenState> {
  RpnCarePlanReviewScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnCarePlanReviewScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/rpn-care-plan-review',
      );
}

final rpn_care_plan_reviewControllerProvider =
    StateNotifierProvider<
      RpnCarePlanReviewScreenController,
      RpnCarePlanReviewScreenState
    >((ref) {
      return RpnCarePlanReviewScreenController(ref);
    });
