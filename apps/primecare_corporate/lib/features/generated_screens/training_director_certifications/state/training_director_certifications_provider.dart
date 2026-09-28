import 'package:flutter_riverpod/legacy.dart';
import '../models/training_director_certifications_model.dart';

class TrainingDirectorCertificationsNotifier extends StateNotifier<TrainingDirectorCertificationsModel> {
  TrainingDirectorCertificationsNotifier() : super(const TrainingDirectorCertificationsModel(isLoading: true));

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

final training_director_certificationsProvider = StateNotifierProvider<TrainingDirectorCertificationsNotifier, TrainingDirectorCertificationsModel>((ref) {
  return TrainingDirectorCertificationsNotifier()..loadData();
});
