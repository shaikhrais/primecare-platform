import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/enterprise_health_model.dart';

class EnterpriseHealthNotifier extends StateNotifier<EnterpriseHealthModel> {
  EnterpriseHealthNotifier() : super(const EnterpriseHealthModel(isLoading: true));

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

final enterprise_healthProvider = StateNotifierProvider<EnterpriseHealthNotifier, EnterpriseHealthModel>((ref) {
  return EnterpriseHealthNotifier()..loadData();
});
