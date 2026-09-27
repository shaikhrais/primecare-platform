import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/certification_renewal_alerts_model.dart';

class CertificationRenewalAlertsNotifier extends StateNotifier<CertificationRenewalAlertsModel> {
  CertificationRenewalAlertsNotifier() : super(const CertificationRenewalAlertsModel(isLoading: true));

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

final certification_renewal_alertsProvider = StateNotifierProvider<CertificationRenewalAlertsNotifier, CertificationRenewalAlertsModel>((ref) {
  return CertificationRenewalAlertsNotifier()..loadData();
});
