import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/default_not_implemented_model.dart';

class DefaultNotImplementedNotifier extends StateNotifier<DefaultNotImplementedModel> {
  DefaultNotImplementedNotifier() : super(const DefaultNotImplementedModel(isLoading: true));

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

final default_not_implementedProvider = StateNotifierProvider<DefaultNotImplementedNotifier, DefaultNotImplementedModel>((ref) {
  return DefaultNotImplementedNotifier()..loadData();
});
