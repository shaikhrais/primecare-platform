import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/enterprise_command_center4_k_model.dart';

class EnterpriseCommandCenter4KNotifier extends StateNotifier<EnterpriseCommandCenter4KModel> {
  EnterpriseCommandCenter4KNotifier() : super(const EnterpriseCommandCenter4KModel(isLoading: true));

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

final enterprise_command_center4_kProvider = StateNotifierProvider<EnterpriseCommandCenter4KNotifier, EnterpriseCommandCenter4KModel>((ref) {
  return EnterpriseCommandCenter4KNotifier()..loadData();
});
