import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarePlanReviewScreenState
    extends DashboardState<CarePlanReviewScreenState> {
  CarePlanReviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CarePlanReviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      CarePlanReviewScreenState(isLoading: isLoading, error: error, data: data);
}

class CarePlanReviewScreenController
    extends BaseDashboardController<CarePlanReviewScreenState> {
  CarePlanReviewScreenController(Ref ref)
    : super(
        ref,
        initialState: CarePlanReviewScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/care-plan-review',
      );
}

final care_plan_reviewControllerProvider =
    StateNotifierProvider<
      CarePlanReviewScreenController,
      CarePlanReviewScreenState
    >((ref) {
      return CarePlanReviewScreenController(ref);
    });
