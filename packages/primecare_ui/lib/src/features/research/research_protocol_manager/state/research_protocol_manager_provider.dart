import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/research_protocol_manager_model.dart';

class ResearchProtocolManagerNotifier extends StateNotifier<ResearchProtocolManagerModel> {
  ResearchProtocolManagerNotifier() : super(const ResearchProtocolManagerModel(isLoading: true));

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

final research_protocol_managerProvider = StateNotifierProvider<ResearchProtocolManagerNotifier, ResearchProtocolManagerModel>((ref) {
  return ResearchProtocolManagerNotifier()..loadData();
});
