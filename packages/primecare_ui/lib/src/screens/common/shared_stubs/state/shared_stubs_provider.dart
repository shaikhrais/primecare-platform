import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shared_stubs_model.dart';

class SharedStubsNotifier extends StateNotifier<SharedStubsModel> {
  SharedStubsNotifier() : super(const SharedStubsModel(isLoading: true));

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

final shared_stubsProvider = StateNotifierProvider<SharedStubsNotifier, SharedStubsModel>((ref) {
  return SharedStubsNotifier()..loadData();
});
