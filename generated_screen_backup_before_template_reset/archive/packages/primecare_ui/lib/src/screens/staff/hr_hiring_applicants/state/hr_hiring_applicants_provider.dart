import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_hiring_applicants_model.dart';

class HrHiringApplicantsNotifier extends StateNotifier<HrHiringApplicantsModel> {
  HrHiringApplicantsNotifier() : super(const HrHiringApplicantsModel(isLoading: true));

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

final hr_hiring_applicantsProvider = StateNotifierProvider<HrHiringApplicantsNotifier, HrHiringApplicantsModel>((ref) {
  return HrHiringApplicantsNotifier()..loadData();
});
