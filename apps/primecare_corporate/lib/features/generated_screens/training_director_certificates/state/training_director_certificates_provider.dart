import 'package:flutter_riverpod/legacy.dart';
import '../models/training_director_certificates_model.dart';

class TrainingDirectorCertificatesNotifier extends StateNotifier<TrainingDirectorCertificatesModel> {
  TrainingDirectorCertificatesNotifier() : super(const TrainingDirectorCertificatesModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final training_director_certificatesProvider = StateNotifierProvider<TrainingDirectorCertificatesNotifier, TrainingDirectorCertificatesModel>((ref) {
  return TrainingDirectorCertificatesNotifier()..loadData();
});
