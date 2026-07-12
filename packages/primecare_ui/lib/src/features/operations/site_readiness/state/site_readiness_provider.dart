import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/site_readiness_model.dart';

class SiteReadinessNotifier extends StateNotifier<SiteReadinessModel> {
  SiteReadinessNotifier() : super(const SiteReadinessModel(isLoading: true));

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

final site_readinessProvider = StateNotifierProvider<SiteReadinessNotifier, SiteReadinessModel>((ref) {
  return SiteReadinessNotifier()..loadData();
});
