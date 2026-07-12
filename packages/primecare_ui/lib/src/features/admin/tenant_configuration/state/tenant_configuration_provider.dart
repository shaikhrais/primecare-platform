import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tenant_configuration_model.dart';

class TenantConfigurationNotifier extends StateNotifier<TenantConfigurationModel> {
  TenantConfigurationNotifier() : super(const TenantConfigurationModel(isLoading: true));

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

final tenant_configurationProvider = StateNotifierProvider<TenantConfigurationNotifier, TenantConfigurationModel>((ref) {
  return TenantConfigurationNotifier()..loadData();
});
