import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/family_member_analytics_model.dart';

class FamilyMemberAnalyticsNotifier extends StateNotifier<FamilyMemberAnalyticsModel> {
  FamilyMemberAnalyticsNotifier() : super(const FamilyMemberAnalyticsModel(isLoading: true));

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

final family_member_analyticsProvider = StateNotifierProvider<FamilyMemberAnalyticsNotifier, FamilyMemberAnalyticsModel>((ref) {
  return FamilyMemberAnalyticsNotifier()..loadData();
});
