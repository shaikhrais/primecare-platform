import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coordinator_waitlist_model.dart';

class CoordinatorWaitlistNotifier extends StateNotifier<CoordinatorWaitlistModel> {
  CoordinatorWaitlistNotifier() : super(const CoordinatorWaitlistModel(isLoading: true));

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

final coordinator_waitlistProvider = StateNotifierProvider<CoordinatorWaitlistNotifier, CoordinatorWaitlistModel>((ref) {
  return CoordinatorWaitlistNotifier()..loadData();
});
