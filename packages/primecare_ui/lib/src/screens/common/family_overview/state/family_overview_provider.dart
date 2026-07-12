import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/family_overview_model.dart';

class FamilyOverviewNotifier extends StateNotifier<FamilyOverviewModel> {
  FamilyOverviewNotifier() : super(const FamilyOverviewModel(isLoading: true));

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

final family_overviewProvider = StateNotifierProvider<FamilyOverviewNotifier, FamilyOverviewModel>((ref) {
  return FamilyOverviewNotifier()..loadData();
});
