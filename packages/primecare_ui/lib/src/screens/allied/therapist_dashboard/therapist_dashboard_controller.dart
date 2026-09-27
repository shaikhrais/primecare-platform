import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  TherapistDashboardState({required this.isLoading, this.error, required this.data});
}

class TherapistDashboardController extends StateNotifier<TherapistDashboardState> {
  TherapistDashboardController() : super(TherapistDashboardState(isLoading: false, data: {'patients': 10, 'notes': 4}));
}

final therapistDashboardControllerProvider = StateNotifierProvider<TherapistDashboardController, TherapistDashboardState>((ref) {
  return TherapistDashboardController();
});
