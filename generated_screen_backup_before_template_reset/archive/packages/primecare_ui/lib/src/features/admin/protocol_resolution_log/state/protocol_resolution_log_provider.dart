import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/protocol_resolution_log_model.dart';

class ProtocolResolutionLogNotifier extends StateNotifier<ProtocolResolutionLogModel> {
  ProtocolResolutionLogNotifier() : super(const ProtocolResolutionLogModel(isLoading: true));

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

final protocol_resolution_logProvider = StateNotifierProvider<ProtocolResolutionLogNotifier, ProtocolResolutionLogModel>((ref) {
  return ProtocolResolutionLogNotifier()..loadData();
});
