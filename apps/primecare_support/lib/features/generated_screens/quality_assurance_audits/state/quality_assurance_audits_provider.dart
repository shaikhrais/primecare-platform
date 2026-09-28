import 'package:flutter_riverpod/legacy.dart';
import '../models/quality_assurance_audits_model.dart';

class QualityAssuranceAuditsNotifier extends StateNotifier<QualityAssuranceAuditsModel> {
  QualityAssuranceAuditsNotifier() : super(const QualityAssuranceAuditsModel(isLoading: true));

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

final quality_assurance_auditsProvider = StateNotifierProvider<QualityAssuranceAuditsNotifier, QualityAssuranceAuditsModel>((ref) {
  return QualityAssuranceAuditsNotifier()..loadData();
});
