// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/02_M_log_franchisee_vetting_call_form_view_model.dart';
import '../mappers/03_D_log_franchisee_vetting_call_form_mapper.dart';

class LogFranchiseeVettingCallFormAdapter
    extends Notifier<LogFranchiseeVettingCallFormViewModel> {
  @override
  LogFranchiseeVettingCallFormViewModel build() {
    return LogFranchiseeVettingCallFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = LogFranchiseeVettingCallFormMapper.toDto(state);
      // ignore: avoid_print
      print('Logging vetting call: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error logging vetting call: \$e');
    }
  }
}

final logFranchiseeVettingCallFormAdapterProvider =
    NotifierProvider<
      LogFranchiseeVettingCallFormAdapter,
      LogFranchiseeVettingCallFormViewModel
    >(() {
      return LogFranchiseeVettingCallFormAdapter();
    });
