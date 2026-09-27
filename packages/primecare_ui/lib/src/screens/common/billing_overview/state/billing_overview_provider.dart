import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/billing_overview_model.dart';

class BillingOverviewNotifier extends StateNotifier<BillingOverviewModel> {
  BillingOverviewNotifier() : super(const BillingOverviewModel(isLoading: true));

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

final billing_overviewProvider = StateNotifierProvider<BillingOverviewNotifier, BillingOverviewModel>((ref) {
  return BillingOverviewNotifier()..loadData();
});
