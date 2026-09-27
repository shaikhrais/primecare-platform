import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_hiring_credentials_model.dart';

class HrHiringCredentialsNotifier extends StateNotifier<HrHiringCredentialsModel> {
  HrHiringCredentialsNotifier() : super(const HrHiringCredentialsModel(isLoading: true));

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

final hr_hiring_credentialsProvider = StateNotifierProvider<HrHiringCredentialsNotifier, HrHiringCredentialsModel>((ref) {
  return HrHiringCredentialsNotifier()..loadData();
});
