import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringInterviewsScreenState
    extends DashboardState<HrHiringInterviewsScreenState> {
  HrHiringInterviewsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrHiringInterviewsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrHiringInterviewsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrHiringInterviewsScreenController
    extends BaseDashboardController<HrHiringInterviewsScreenState> {
  HrHiringInterviewsScreenController(Ref ref)
    : super(
        ref,
        initialState: HrHiringInterviewsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/franchise/roles/hr_hiring/interviews',
      );
}

final hr_hiring_interviewsControllerProvider =
    StateNotifierProvider<
      HrHiringInterviewsScreenController,
      HrHiringInterviewsScreenState
    >((ref) {
      return HrHiringInterviewsScreenController(ref);
    });
