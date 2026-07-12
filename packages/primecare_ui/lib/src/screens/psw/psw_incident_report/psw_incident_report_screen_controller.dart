import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportIncidentScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ReportIncidentScreenState({required this.isLoading, this.error, required this.data});

  ReportIncidentScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ReportIncidentScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ReportIncidentScreenController extends StateNotifier<ReportIncidentScreenState> {
  final Ref ref;
  ReportIncidentScreenController(this.ref) : super(ReportIncidentScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/psw/incident-report');
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          data: response.data is Map ? Map<String, dynamic>.from(response.data) : {},
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.error ?? 'Failed to load live data',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> syncData() async {
    await loadDashboardData();
  }
}

final psw_incident_reportControllerProvider = StateNotifierProvider<ReportIncidentScreenController, ReportIncidentScreenState>((ref) {
  return ReportIncidentScreenController(ref);
});
