import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgentDispatchScreenState
    extends DashboardState<AgentDispatchScreenState> {
  AgentDispatchScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  AgentDispatchScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      AgentDispatchScreenState(isLoading: isLoading, error: error, data: data);
}

class AgentDispatchScreenController
    extends BaseDashboardController<AgentDispatchScreenState> {
  AgentDispatchScreenController(Ref ref)
    : super(
        ref,
        initialState: AgentDispatchScreenState(isLoading: true, data: {}),
        endpoint: '/common/agent-dispatch',
      );
}

final agent_dispatchControllerProvider =
    StateNotifierProvider<
      AgentDispatchScreenController,
      AgentDispatchScreenState
    >((ref) {
      return AgentDispatchScreenController(ref);
    });
