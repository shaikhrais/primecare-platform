import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_director_approvals_model.dart';

class ClinicalDirectorApprovalsNotifier extends StateNotifier<ClinicalDirectorApprovalsModel> {
  ClinicalDirectorApprovalsNotifier() : super(const ClinicalDirectorApprovalsModel(isLoading: true));

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

final clinical_director_approvalsProvider = StateNotifierProvider<ClinicalDirectorApprovalsNotifier, ClinicalDirectorApprovalsModel>((ref) {
  return ClinicalDirectorApprovalsNotifier()..loadData();
});
