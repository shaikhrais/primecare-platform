import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundManagementScreenState
    extends DashboardState<RefundManagementScreenState> {
  RefundManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RefundManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RefundManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RefundManagementScreenController
    extends BaseDashboardController<RefundManagementScreenState> {
  RefundManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: RefundManagementScreenState(isLoading: true, data: {}),
        endpoint: '/staff/refund-management',
      );
}

final refund_managementControllerProvider =
    StateNotifierProvider<
      RefundManagementScreenController,
      RefundManagementScreenState
    >((ref) {
      return RefundManagementScreenController(ref);
    });
