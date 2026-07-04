import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cto_integrations_model.dart';

class CtoIntegrationsNotifier extends StateNotifier<CtoIntegrationsModel> {
  CtoIntegrationsNotifier() : super(const CtoIntegrationsModel(isLoading: true));

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

final cto_integrationsProvider = StateNotifierProvider<CtoIntegrationsNotifier, CtoIntegrationsModel>((ref) {
  return CtoIntegrationsNotifier()..loadData();
});
