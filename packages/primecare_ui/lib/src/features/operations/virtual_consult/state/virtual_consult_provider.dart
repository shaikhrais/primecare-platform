import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/virtual_consult_model.dart';

class VirtualConsultNotifier extends StateNotifier<VirtualConsultModel> {
  VirtualConsultNotifier() : super(const VirtualConsultModel(isLoading: true));

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

final virtual_consultProvider = StateNotifierProvider<VirtualConsultNotifier, VirtualConsultModel>((ref) {
  return VirtualConsultNotifier()..loadData();
});
