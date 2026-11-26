import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterpriseCommandCenter4KScreenState
    extends DashboardState<EnterpriseCommandCenter4KScreenState> {
  EnterpriseCommandCenter4KScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  EnterpriseCommandCenter4KScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => EnterpriseCommandCenter4KScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class EnterpriseCommandCenter4KScreenController
    extends BaseDashboardController<EnterpriseCommandCenter4KScreenState> {
  EnterpriseCommandCenter4KScreenController(Ref ref)
    : super(
        ref,
        initialState: EnterpriseCommandCenter4KScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/enterprise-command-center4-k',
      );
}

final enterprise_command_center4_kControllerProvider =
    StateNotifierProvider<
      EnterpriseCommandCenter4KScreenController,
      EnterpriseCommandCenter4KScreenState
    >((ref) {
      return EnterpriseCommandCenter4KScreenController(ref);
    });
