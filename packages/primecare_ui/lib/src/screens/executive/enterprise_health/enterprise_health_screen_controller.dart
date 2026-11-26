import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterpriseHealthScreenState
    extends DashboardState<EnterpriseHealthScreenState> {
  EnterpriseHealthScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  EnterpriseHealthScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => EnterpriseHealthScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class EnterpriseHealthScreenController
    extends BaseDashboardController<EnterpriseHealthScreenState> {
  EnterpriseHealthScreenController(Ref ref)
    : super(
        ref,
        initialState: EnterpriseHealthScreenState(isLoading: true, data: {}),
        endpoint: '/executive/enterprise-health',
      );
}

final enterprise_healthControllerProvider =
    StateNotifierProvider<
      EnterpriseHealthScreenController,
      EnterpriseHealthScreenState
    >((ref) {
      return EnterpriseHealthScreenController(ref);
    });
