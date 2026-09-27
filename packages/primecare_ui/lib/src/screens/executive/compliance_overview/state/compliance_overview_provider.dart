import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_overview_model.dart';

class ComplianceOverviewNotifier extends StateNotifier<ComplianceOverviewModel> {
  ComplianceOverviewNotifier() : super(const ComplianceOverviewModel(isLoading: true));

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

final compliance_overviewProvider = StateNotifierProvider<ComplianceOverviewNotifier, ComplianceOverviewModel>((ref) {
  return ComplianceOverviewNotifier()..loadData();
});
