import 'package:flutter_riverpod/legacy.dart';
import '../models/cto_platform_usage_model.dart';

class CtoPlatformUsageNotifier extends StateNotifier<CtoPlatformUsageModel> {
  CtoPlatformUsageNotifier() : super(const CtoPlatformUsageModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final cto_platform_usageProvider = StateNotifierProvider<CtoPlatformUsageNotifier, CtoPlatformUsageModel>((ref) {
  return CtoPlatformUsageNotifier()..loadData();
});
