import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/audits_model.dart';

class AuditsNotifier extends StateNotifier<AuditsModel> {
  AuditsNotifier() : super(const AuditsModel(isLoading: true));

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

final auditsProvider = StateNotifierProvider<AuditsNotifier, AuditsModel>((ref) {
  return AuditsNotifier()..loadData();
});
