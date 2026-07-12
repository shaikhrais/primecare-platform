import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_hiring_offers_model.dart';

class HrHiringOffersNotifier extends StateNotifier<HrHiringOffersModel> {
  HrHiringOffersNotifier() : super(const HrHiringOffersModel(isLoading: true));

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

final hr_hiring_offersProvider = StateNotifierProvider<HrHiringOffersNotifier, HrHiringOffersModel>((ref) {
  return HrHiringOffersNotifier()..loadData();
});
