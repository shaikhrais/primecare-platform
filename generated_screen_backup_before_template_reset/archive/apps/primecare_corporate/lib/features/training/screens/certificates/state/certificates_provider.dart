import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/certificates_model.dart';

class CertificatesNotifier extends StateNotifier<CertificatesModel> {
  CertificatesNotifier() : super(const CertificatesModel(isLoading: true));

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

final certificatesProvider = StateNotifierProvider<CertificatesNotifier, CertificatesModel>((ref) {
  return CertificatesNotifier()..loadData();
});
