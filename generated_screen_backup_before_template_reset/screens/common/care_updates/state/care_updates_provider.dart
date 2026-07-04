import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/care_updates_model.dart';

class CareUpdatesNotifier extends StateNotifier<CareUpdatesModel> {
  CareUpdatesNotifier() : super(const CareUpdatesModel(isLoading: true));

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

final care_updatesProvider = StateNotifierProvider<CareUpdatesNotifier, CareUpdatesModel>((ref) {
  return CareUpdatesNotifier()..loadData();
});
