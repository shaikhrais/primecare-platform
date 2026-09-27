import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/family_care_updates_model.dart';

class FamilyCareUpdatesNotifier extends StateNotifier<FamilyCareUpdatesModel> {
  FamilyCareUpdatesNotifier() : super(const FamilyCareUpdatesModel(isLoading: true));

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

final family_care_updatesProvider = StateNotifierProvider<FamilyCareUpdatesNotifier, FamilyCareUpdatesModel>((ref) {
  return FamilyCareUpdatesNotifier()..loadData();
});
