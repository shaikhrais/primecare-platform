import 'package:flutter_riverpod/legacy.dart';
import '../models/client_care_team_model.dart';

class ClientCareTeamNotifier extends StateNotifier<ClientCareTeamModel> {
  ClientCareTeamNotifier() : super(const ClientCareTeamModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final client_care_teamProvider = StateNotifierProvider<ClientCareTeamNotifier, ClientCareTeamModel>((ref) {
  return ClientCareTeamNotifier()..loadData();
});
