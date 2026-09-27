import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/adverse_event_reporting_portal_model.dart';

class AdverseEventReportingPortalNotifier extends StateNotifier<AdverseEventReportingPortalModel> {
  AdverseEventReportingPortalNotifier() : super(const AdverseEventReportingPortalModel(isLoading: true));

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

final adverse_event_reporting_portalProvider = StateNotifierProvider<AdverseEventReportingPortalNotifier, AdverseEventReportingPortalModel>((ref) {
  return AdverseEventReportingPortalNotifier()..loadData();
});
