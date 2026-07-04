import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/client_issue_model.dart';

class ClientIssueNotifier extends StateNotifier<ClientIssueModel> {
  ClientIssueNotifier() : super(const ClientIssueModel(isLoading: true));

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

final client_issueProvider = StateNotifierProvider<ClientIssueNotifier, ClientIssueModel>((ref) {
  return ClientIssueNotifier()..loadData();
});
