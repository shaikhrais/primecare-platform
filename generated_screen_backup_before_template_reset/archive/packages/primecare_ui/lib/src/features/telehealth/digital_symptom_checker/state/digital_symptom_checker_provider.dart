import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/digital_symptom_checker_model.dart';

class DigitalSymptomCheckerNotifier extends StateNotifier<DigitalSymptomCheckerModel> {
  DigitalSymptomCheckerNotifier() : super(const DigitalSymptomCheckerModel(isLoading: true));

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

final digital_symptom_checkerProvider = StateNotifierProvider<DigitalSymptomCheckerNotifier, DigitalSymptomCheckerModel>((ref) {
  return DigitalSymptomCheckerNotifier()..loadData();
});
