import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_issue_model.dart';

class ServiceIssueNotifier extends StateNotifier<ServiceIssueModel> {
  ServiceIssueNotifier() : super(const ServiceIssueModel(isLoading: true));

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

final service_issueProvider = StateNotifierProvider<ServiceIssueNotifier, ServiceIssueModel>((ref) {
  return ServiceIssueNotifier()..loadData();
});
