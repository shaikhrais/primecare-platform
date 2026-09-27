import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chiropractor_client_intake_model.dart';

class ChiropractorClientIntakeNotifier extends StateNotifier<ChiropractorClientIntakeModel> {
  ChiropractorClientIntakeNotifier() : super(const ChiropractorClientIntakeModel(isLoading: true));

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

final chiropractor_client_intakeProvider = StateNotifierProvider<ChiropractorClientIntakeNotifier, ChiropractorClientIntakeModel>((ref) {
  return ChiropractorClientIntakeNotifier()..loadData();
});
