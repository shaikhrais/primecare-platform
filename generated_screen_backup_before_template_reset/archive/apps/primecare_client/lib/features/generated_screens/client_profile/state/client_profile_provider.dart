import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/client_profile_model.dart';

class ClientProfileNotifier extends StateNotifier<ClientProfileModel> {
  ClientProfileNotifier() : super(const ClientProfileModel(isLoading: true));

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

final client_profileProvider = StateNotifierProvider<ClientProfileNotifier, ClientProfileModel>((ref) {
  return ClientProfileNotifier()..loadData();
});
