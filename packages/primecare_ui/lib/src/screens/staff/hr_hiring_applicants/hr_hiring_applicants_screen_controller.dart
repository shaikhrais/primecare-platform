import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringApplicantsScreenState
    extends DashboardState<HrHiringApplicantsScreenState> {
  HrHiringApplicantsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrHiringApplicantsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrHiringApplicantsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrHiringApplicantsScreenController
    extends BaseDashboardController<HrHiringApplicantsScreenState> {
  HrHiringApplicantsScreenController(Ref ref)
    : super(
        ref,
        initialState: HrHiringApplicantsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/franchise/roles/hr_hiring/applicants',
      );
}

final hr_hiring_applicantsControllerProvider =
    StateNotifierProvider<
      HrHiringApplicantsScreenController,
      HrHiringApplicantsScreenState
    >((ref) {
      return HrHiringApplicantsScreenController(ref);
    });
