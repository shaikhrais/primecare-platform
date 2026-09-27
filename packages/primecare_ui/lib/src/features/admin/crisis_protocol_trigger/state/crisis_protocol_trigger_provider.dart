import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/crisis_protocol_trigger_model.dart';

class CrisisProtocolTriggerNotifier extends StateNotifier<CrisisProtocolTriggerModel> {
  CrisisProtocolTriggerNotifier() : super(const CrisisProtocolTriggerModel(isLoading: true));

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

final crisis_protocol_triggerProvider = StateNotifierProvider<CrisisProtocolTriggerNotifier, CrisisProtocolTriggerModel>((ref) {
  return CrisisProtocolTriggerNotifier()..loadData();
});
