import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorReferralsScreenState
    extends DashboardState<IntakeCoordinatorReferralsScreenState> {
  IntakeCoordinatorReferralsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeCoordinatorReferralsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorReferralsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeCoordinatorReferralsScreenController
    extends BaseDashboardController<IntakeCoordinatorReferralsScreenState> {
  IntakeCoordinatorReferralsScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeCoordinatorReferralsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/intake-coordinator-referrals',
      );
}

final intake_coordinator_referralsControllerProvider =
    StateNotifierProvider<
      IntakeCoordinatorReferralsScreenController,
      IntakeCoordinatorReferralsScreenState
    >((ref) {
      return IntakeCoordinatorReferralsScreenController(ref);
    });
