import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/f_a_q_manager_model.dart';

class FAQManagerNotifier extends StateNotifier<FAQManagerModel> {
  FAQManagerNotifier() : super(const FAQManagerModel(isLoading: true));

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

final f_a_q_managerProvider = StateNotifierProvider<FAQManagerNotifier, FAQManagerModel>((ref) {
  return FAQManagerNotifier()..loadData();
});
