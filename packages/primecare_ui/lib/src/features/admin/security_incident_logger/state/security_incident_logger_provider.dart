import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/security_incident_logger_model.dart';

class SecurityIncidentLoggerNotifier extends StateNotifier<SecurityIncidentLoggerModel> {
  SecurityIncidentLoggerNotifier() : super(const SecurityIncidentLoggerModel(isLoading: true));

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

final security_incident_loggerProvider = StateNotifierProvider<SecurityIncidentLoggerNotifier, SecurityIncidentLoggerModel>((ref) {
  return SecurityIncidentLoggerNotifier()..loadData();
});
