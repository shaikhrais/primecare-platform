import 'package:flutter_riverpod/legacy.dart';
import '../models/training_coordinator_certifications_model.dart';

class TrainingCoordinatorCertificationsNotifier extends StateNotifier<TrainingCoordinatorCertificationsModel> {
  TrainingCoordinatorCertificationsNotifier() : super(const TrainingCoordinatorCertificationsModel(isLoading: true));

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

final training_coordinator_certificationsProvider = StateNotifierProvider<TrainingCoordinatorCertificationsNotifier, TrainingCoordinatorCertificationsModel>((ref) {
  return TrainingCoordinatorCertificationsNotifier()..loadData();
});
