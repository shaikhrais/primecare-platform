import 'package:flutter_riverpod/legacy.dart';
import '../models/coo_issue_escalations_model.dart';

class CooIssueEscalationsNotifier extends StateNotifier<CooIssueEscalationsModel> {
  CooIssueEscalationsNotifier() : super(const CooIssueEscalationsModel(isLoading: true));

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

final coo_issue_escalationsProvider = StateNotifierProvider<CooIssueEscalationsNotifier, CooIssueEscalationsModel>((ref) {
  return CooIssueEscalationsNotifier()..loadData();
});
