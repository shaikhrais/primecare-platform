import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hsw_adl_logger_model.dart';

class HswAdlLoggerNotifier extends StateNotifier<HswAdlLoggerModel> {
  HswAdlLoggerNotifier() : super(const HswAdlLoggerModel(isLoading: true));

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

final hsw_adl_loggerProvider = StateNotifierProvider<HswAdlLoggerNotifier, HswAdlLoggerModel>((ref) {
  return HswAdlLoggerNotifier()..loadData();
});
