import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/client_intake_model.dart';

class ClientIntakeNotifier extends StateNotifier<ClientIntakeModel> {
  ClientIntakeNotifier() : super(const ClientIntakeModel(isLoading: true));

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

final client_intakeProvider = StateNotifierProvider<ClientIntakeNotifier, ClientIntakeModel>((ref) {
  return ClientIntakeNotifier()..loadData();
});
