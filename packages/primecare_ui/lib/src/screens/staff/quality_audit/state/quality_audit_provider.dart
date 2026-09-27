import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quality_audit_model.dart';

class QualityAuditNotifier extends StateNotifier<QualityAuditModel> {
  QualityAuditNotifier() : super(const QualityAuditModel(isLoading: true));

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

final quality_auditProvider = StateNotifierProvider<QualityAuditNotifier, QualityAuditModel>((ref) {
  return QualityAuditNotifier()..loadData();
});
