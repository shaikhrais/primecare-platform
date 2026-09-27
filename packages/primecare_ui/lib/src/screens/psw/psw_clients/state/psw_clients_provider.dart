import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_clients_model.dart';

class PswClientsNotifier extends StateNotifier<PswClientsModel> {
  PswClientsNotifier() : super(const PswClientsModel(isLoading: true));

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

final psw_clientsProvider = StateNotifierProvider<PswClientsNotifier, PswClientsModel>((ref) {
  return PswClientsNotifier()..loadData();
});
