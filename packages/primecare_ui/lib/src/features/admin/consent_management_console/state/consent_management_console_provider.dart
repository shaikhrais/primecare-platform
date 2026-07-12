import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/consent_management_console_model.dart';

class ConsentManagementConsoleNotifier extends StateNotifier<ConsentManagementConsoleModel> {
  ConsentManagementConsoleNotifier() : super(const ConsentManagementConsoleModel(isLoading: true));

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

final consent_management_consoleProvider = StateNotifierProvider<ConsentManagementConsoleNotifier, ConsentManagementConsoleModel>((ref) {
  return ConsentManagementConsoleNotifier()..loadData();
});
