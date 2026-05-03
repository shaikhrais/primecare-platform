import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/logger.dart';

final careAngelManagementProvider = NotifierProvider<CareAngelManagementController, CareAngelManagementState>(() {
  return CareAngelManagementController();
});

class CareAngelManagementState {
  final bool isLoading;
  final List<Map<String, dynamic>> angels;
  final String? error;

  CareAngelManagementState({
    this.isLoading = false,
    this.angels = const [],
    this.error,
  });

  CareAngelManagementState copyWith({
    bool? isLoading,
    List<Map<String, dynamic>>? angels,
    String? error,
  }) {
    return CareAngelManagementState(
      isLoading: isLoading ?? this.isLoading,
      angels: angels ?? this.angels,
      error: error ?? this.error,
    );
  }
}

class CareAngelManagementController extends Notifier<CareAngelManagementState> {
  @override
  CareAngelManagementState build() {
    Future.microtask(() => loadAngels());
    return CareAngelManagementState();
  }

  Future<void> loadAngels() async {
    state = state.copyWith(isLoading: true);
    try {
      // Simulation of API call
      await Future.delayed(const Duration(seconds: 1));
      final mockData = [
        {'id': 'CA-001', 'name': 'Sarah Jenkins', 'status': 'Active', 'compliance': '100%'},
        {'id': 'CA-002', 'name': 'Michael Chen', 'status': 'On Break', 'compliance': '95%'},
        {'id': 'CA-003', 'name': 'Emma Wilson', 'status': 'Active', 'compliance': '100%'},
      ];
      state = state.copyWith(isLoading: false, angels: mockData);
    } catch (e) {
      AppLogger.e('Error loading Care Angels: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateAngelStatus(String id, String status) {
    final updatedAngels = state.angels.map((a) {
      if (a['id'] == id) {
        return {...a, 'status': status};
      }
      return a;
    }).toList();
    state = state.copyWith(angels: updatedAngels);
  }
}
