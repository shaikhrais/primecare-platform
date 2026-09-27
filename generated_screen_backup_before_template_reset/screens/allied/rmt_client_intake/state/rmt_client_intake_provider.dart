import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_client_intake_model.dart';

class RmtClientIntakeNotifier extends StateNotifier<RmtClientIntakeModel> {
  RmtClientIntakeNotifier() : super(const RmtClientIntakeModel(isLoading: true));

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

final rmt_client_intakeProvider = StateNotifierProvider<RmtClientIntakeNotifier, RmtClientIntakeModel>((ref) {
  return RmtClientIntakeNotifier()..loadData();
});
