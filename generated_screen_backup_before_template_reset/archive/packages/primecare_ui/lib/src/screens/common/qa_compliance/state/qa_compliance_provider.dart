import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/qa_compliance_model.dart';

class QaComplianceNotifier extends StateNotifier<QaComplianceModel> {
  QaComplianceNotifier() : super(const QaComplianceModel(isLoading: true));

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

final qa_complianceProvider = StateNotifierProvider<QaComplianceNotifier, QaComplianceModel>((ref) {
  return QaComplianceNotifier()..loadData();
});
