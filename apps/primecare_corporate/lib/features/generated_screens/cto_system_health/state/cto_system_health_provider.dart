import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cto_system_health_model.dart';

class CtoSystemHealthNotifier extends StateNotifier<CtoSystemHealthModel> {
  CtoSystemHealthNotifier() : super(const CtoSystemHealthModel(isLoading: true));

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

final cto_system_healthProvider = StateNotifierProvider<CtoSystemHealthNotifier, CtoSystemHealthModel>((ref) {
  return CtoSystemHealthNotifier()..loadData();
});
