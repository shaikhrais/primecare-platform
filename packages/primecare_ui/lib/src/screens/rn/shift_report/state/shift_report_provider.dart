import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shift_report_model.dart';

class ShiftReportNotifier extends StateNotifier<ShiftReportModel> {
  ShiftReportNotifier() : super(const ShiftReportModel(isLoading: true));

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

final shift_reportProvider = StateNotifierProvider<ShiftReportNotifier, ShiftReportModel>((ref) {
  return ShiftReportNotifier()..loadData();
});
