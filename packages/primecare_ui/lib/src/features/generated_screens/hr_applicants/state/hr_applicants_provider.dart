import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_applicants_model.dart';

class HrApplicantsNotifier extends StateNotifier<HrApplicantsModel> {
  HrApplicantsNotifier() : super(const HrApplicantsModel(isLoading: true));

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

final hr_applicantsProvider = StateNotifierProvider<HrApplicantsNotifier, HrApplicantsModel>((ref) {
  return HrApplicantsNotifier()..loadData();
});
