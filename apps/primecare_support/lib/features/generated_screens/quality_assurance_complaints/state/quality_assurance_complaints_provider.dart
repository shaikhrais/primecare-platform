import 'package:flutter_riverpod/legacy.dart';
import '../models/quality_assurance_complaints_model.dart';

class QualityAssuranceComplaintsNotifier extends StateNotifier<QualityAssuranceComplaintsModel> {
  QualityAssuranceComplaintsNotifier() : super(const QualityAssuranceComplaintsModel(isLoading: true));

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

final quality_assurance_complaintsProvider = StateNotifierProvider<QualityAssuranceComplaintsNotifier, QualityAssuranceComplaintsModel>((ref) {
  return QualityAssuranceComplaintsNotifier()..loadData();
});
