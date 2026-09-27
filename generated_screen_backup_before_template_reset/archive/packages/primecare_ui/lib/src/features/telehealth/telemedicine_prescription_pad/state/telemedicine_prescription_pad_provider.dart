import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/telemedicine_prescription_pad_model.dart';

class TelemedicinePrescriptionPadNotifier extends StateNotifier<TelemedicinePrescriptionPadModel> {
  TelemedicinePrescriptionPadNotifier() : super(const TelemedicinePrescriptionPadModel(isLoading: true));

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

final telemedicine_prescription_padProvider = StateNotifierProvider<TelemedicinePrescriptionPadNotifier, TelemedicinePrescriptionPadModel>((ref) {
  return TelemedicinePrescriptionPadNotifier()..loadData();
});
