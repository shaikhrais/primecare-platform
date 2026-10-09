import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestComplianceScreenState
    extends DashboardState<GuestComplianceScreenState> {
  GuestComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GuestComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GuestComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GuestComplianceScreenController
    extends BaseDashboardController<GuestComplianceScreenState> {
  GuestComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: GuestComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/common/guest-compliance',
      );
}

final guest_complianceControllerProvider =
    StateNotifierProvider<
      GuestComplianceScreenController,
      GuestComplianceScreenState
    >((ref) {
      return GuestComplianceScreenController(ref);
    });
