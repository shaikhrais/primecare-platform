import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lead_conversion_funnel_model.dart';

class LeadConversionFunnelNotifier extends StateNotifier<LeadConversionFunnelModel> {
  LeadConversionFunnelNotifier() : super(const LeadConversionFunnelModel(isLoading: true));

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

final lead_conversion_funnelProvider = StateNotifierProvider<LeadConversionFunnelNotifier, LeadConversionFunnelModel>((ref) {
  return LeadConversionFunnelNotifier()..loadData();
});
