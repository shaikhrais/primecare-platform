import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReferralManagementScreenState
    extends DashboardState<ReferralManagementScreenState> {
  ReferralManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ReferralManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ReferralManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ReferralManagementScreenController
    extends BaseDashboardController<ReferralManagementScreenState> {
  ReferralManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: ReferralManagementScreenState(isLoading: true, data: {}),
        endpoint:
            '/offices/clinical/roles/intake_coordinator/referral-management',
      );
}

final referral_managementControllerProvider =
    StateNotifierProvider<
      ReferralManagementScreenController,
      ReferralManagementScreenState
    >((ref) {
      return ReferralManagementScreenController(ref);
    });
