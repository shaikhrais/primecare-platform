import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/communication_model.dart';

class CommunicationNotifier extends StateNotifier<CommunicationModel> {
  CommunicationNotifier() : super(const CommunicationModel(isLoading: true));

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

final communicationProvider = StateNotifierProvider<CommunicationNotifier, CommunicationModel>((ref) {
  return CommunicationNotifier()..loadData();
});
