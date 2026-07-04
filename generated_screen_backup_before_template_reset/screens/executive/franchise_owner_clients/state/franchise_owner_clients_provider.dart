import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_owner_clients_model.dart';

class FranchiseOwnerClientsNotifier extends StateNotifier<FranchiseOwnerClientsModel> {
  FranchiseOwnerClientsNotifier() : super(const FranchiseOwnerClientsModel(isLoading: true));

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

final franchise_owner_clientsProvider = StateNotifierProvider<FranchiseOwnerClientsNotifier, FranchiseOwnerClientsModel>((ref) {
  return FranchiseOwnerClientsNotifier()..loadData();
});
