import 'package:flutter_riverpod/legacy.dart';
import '../models/quality_assurance_reports_model.dart';

class QualityAssuranceReportsNotifier extends StateNotifier<QualityAssuranceReportsModel> {
  QualityAssuranceReportsNotifier() : super(const QualityAssuranceReportsModel(isLoading: true));

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

final quality_assurance_reportsProvider = StateNotifierProvider<QualityAssuranceReportsNotifier, QualityAssuranceReportsModel>((ref) {
  return QualityAssuranceReportsNotifier()..loadData();
});
