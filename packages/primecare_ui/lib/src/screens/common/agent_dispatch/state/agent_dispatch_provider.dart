import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/agent_dispatch_model.dart';

class AgentDispatchNotifier extends StateNotifier<AgentDispatchModel> {
  AgentDispatchNotifier() : super(const AgentDispatchModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final agent_dispatchProvider = StateNotifierProvider<AgentDispatchNotifier, AgentDispatchModel>((ref) {
  return AgentDispatchNotifier()..loadData();
});
