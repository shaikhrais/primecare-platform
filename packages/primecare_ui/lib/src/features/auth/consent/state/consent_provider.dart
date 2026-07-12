import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/consent_model.dart';

class ConsentNotifier extends StateNotifier<ConsentModel> {
  ConsentNotifier() : super(const ConsentModel(isLoading: true));

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

final consentProvider = StateNotifierProvider<ConsentNotifier, ConsentModel>((ref) {
  return ConsentNotifier()..loadData();
});
