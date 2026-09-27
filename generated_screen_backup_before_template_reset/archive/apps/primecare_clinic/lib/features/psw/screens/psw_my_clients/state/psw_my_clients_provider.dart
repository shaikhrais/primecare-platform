import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_my_clients_model.dart';

class PswMyClientsNotifier extends StateNotifier<PswMyClientsModel> {
  PswMyClientsNotifier() : super(const PswMyClientsModel(isLoading: true));

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

final psw_my_clientsProvider = StateNotifierProvider<PswMyClientsNotifier, PswMyClientsModel>((ref) {
  return PswMyClientsNotifier()..loadData();
});
