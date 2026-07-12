import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mobile_clinic_dispatch_model.dart';

class MobileClinicDispatchNotifier extends StateNotifier<MobileClinicDispatchModel> {
  MobileClinicDispatchNotifier() : super(const MobileClinicDispatchModel(isLoading: true));

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

final mobile_clinic_dispatchProvider = StateNotifierProvider<MobileClinicDispatchNotifier, MobileClinicDispatchModel>((ref) {
  return MobileClinicDispatchNotifier()..loadData();
});
