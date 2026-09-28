import 'package:flutter_riverpod/legacy.dart';
import '../models/certifications_model.dart';

class CertificationsNotifier extends StateNotifier<CertificationsModel> {
  CertificationsNotifier() : super(const CertificationsModel(isLoading: true));

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

final certificationsProvider = StateNotifierProvider<CertificationsNotifier, CertificationsModel>((ref) {
  return CertificationsNotifier()..loadData();
});
