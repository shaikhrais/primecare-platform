import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vulnerable_population_registry_model.dart';

class VulnerablePopulationRegistryNotifier extends StateNotifier<VulnerablePopulationRegistryModel> {
  VulnerablePopulationRegistryNotifier() : super(const VulnerablePopulationRegistryModel(isLoading: true));

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

final vulnerable_population_registryProvider = StateNotifierProvider<VulnerablePopulationRegistryNotifier, VulnerablePopulationRegistryModel>((ref) {
  return VulnerablePopulationRegistryNotifier()..loadData();
});
