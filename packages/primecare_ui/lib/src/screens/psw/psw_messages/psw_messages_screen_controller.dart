import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  MessagesState({required this.isLoading, this.error, required this.data});

  MessagesState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return MessagesState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class MessagesController extends StateNotifier<MessagesState> {
  final Ref ref;
  MessagesController(this.ref) : super(MessagesState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/psw/messages');
      if (response.isSuccess) {
        final responseData = response.data;
        state = state.copyWith(
          isLoading: false,
          data: responseData is Map ? Map<String, dynamic>.from(responseData) : {},
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

final psw_messagesControllerProvider = StateNotifierProvider<MessagesController, MessagesState>((ref) {
  return MessagesController(ref);
});
