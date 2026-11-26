import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerComplianceScreenState
    extends DashboardState<OwnerComplianceScreenState> {
  OwnerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OwnerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OwnerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class OwnerComplianceScreenController
    extends BaseDashboardController<OwnerComplianceScreenState> {
  OwnerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: OwnerComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/executive/owner-compliance',
      );
}

final owner_complianceControllerProvider =
    StateNotifierProvider<
      OwnerComplianceScreenController,
      OwnerComplianceScreenState
    >((ref) {
      return OwnerComplianceScreenController(ref);
    });
