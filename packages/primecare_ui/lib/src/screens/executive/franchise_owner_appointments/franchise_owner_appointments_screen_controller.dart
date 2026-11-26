import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerAppointmentsScreenState
    extends DashboardState<FranchiseOwnerAppointmentsScreenState> {
  FranchiseOwnerAppointmentsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseOwnerAppointmentsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerAppointmentsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseOwnerAppointmentsScreenController
    extends BaseDashboardController<FranchiseOwnerAppointmentsScreenState> {
  FranchiseOwnerAppointmentsScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseOwnerAppointmentsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/franchise/roles/franchise_owner/appointments',
      );
}

final franchise_owner_appointmentsControllerProvider =
    StateNotifierProvider<
      FranchiseOwnerAppointmentsScreenController,
      FranchiseOwnerAppointmentsScreenState
    >((ref) {
      return FranchiseOwnerAppointmentsScreenController(ref);
    });
