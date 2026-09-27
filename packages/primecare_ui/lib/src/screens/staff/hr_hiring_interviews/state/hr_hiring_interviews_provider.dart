import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_hiring_interviews_model.dart';

class HrHiringInterviewsNotifier extends StateNotifier<HrHiringInterviewsModel> {
  HrHiringInterviewsNotifier() : super(const HrHiringInterviewsModel(isLoading: true));

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

final hr_hiring_interviewsProvider = StateNotifierProvider<HrHiringInterviewsNotifier, HrHiringInterviewsModel>((ref) {
  return HrHiringInterviewsNotifier()..loadData();
});
