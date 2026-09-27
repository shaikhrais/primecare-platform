import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/configuration_version_control_model.dart';

class ConfigurationVersionControlNotifier extends StateNotifier<ConfigurationVersionControlModel> {
  ConfigurationVersionControlNotifier() : super(const ConfigurationVersionControlModel(isLoading: true));

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

final configuration_version_controlProvider = StateNotifierProvider<ConfigurationVersionControlNotifier, ConfigurationVersionControlModel>((ref) {
  return ConfigurationVersionControlNotifier()..loadData();
});
