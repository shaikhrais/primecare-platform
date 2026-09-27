import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/interview_scheduling_model.dart';

class InterviewSchedulingNotifier extends StateNotifier<InterviewSchedulingModel> {
  InterviewSchedulingNotifier() : super(const InterviewSchedulingModel(isLoading: true));

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

final interview_schedulingProvider = StateNotifierProvider<InterviewSchedulingNotifier, InterviewSchedulingModel>((ref) {
  return InterviewSchedulingNotifier()..loadData();
});
