import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/sso_redirect_model.dart';

class SsoRedirectNotifier extends StateNotifier<SsoRedirectModel> {
  SsoRedirectNotifier() : super(const SsoRedirectModel(isLoading: true));

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

final sso_redirectProvider = StateNotifierProvider<SsoRedirectNotifier, SsoRedirectModel>((ref) {
  return SsoRedirectNotifier()..loadData();
});
