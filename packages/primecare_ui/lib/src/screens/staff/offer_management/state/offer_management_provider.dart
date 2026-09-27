import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/offer_management_model.dart';

class OfferManagementNotifier extends StateNotifier<OfferManagementModel> {
  OfferManagementNotifier() : super(const OfferManagementModel(isLoading: true));

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

final offer_managementProvider = StateNotifierProvider<OfferManagementNotifier, OfferManagementModel>((ref) {
  return OfferManagementNotifier()..loadData();
});
