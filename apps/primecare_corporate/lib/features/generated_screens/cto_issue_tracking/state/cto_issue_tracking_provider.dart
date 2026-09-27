import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cto_issue_tracking_model.dart';

class CtoIssueTrackingNotifier extends StateNotifier<CtoIssueTrackingModel> {
  CtoIssueTrackingNotifier() : super(const CtoIssueTrackingModel(isLoading: true));

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

final cto_issue_trackingProvider = StateNotifierProvider<CtoIssueTrackingNotifier, CtoIssueTrackingModel>((ref) {
  return CtoIssueTrackingNotifier()..loadData();
});
