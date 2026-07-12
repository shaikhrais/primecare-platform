import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_coordinator_referrals_model.dart';

class IntakeCoordinatorReferralsNotifier extends StateNotifier<IntakeCoordinatorReferralsModel> {
  IntakeCoordinatorReferralsNotifier() : super(const IntakeCoordinatorReferralsModel(isLoading: true));

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

final intake_coordinator_referralsProvider = StateNotifierProvider<IntakeCoordinatorReferralsNotifier, IntakeCoordinatorReferralsModel>((ref) {
  return IntakeCoordinatorReferralsNotifier()..loadData();
});
