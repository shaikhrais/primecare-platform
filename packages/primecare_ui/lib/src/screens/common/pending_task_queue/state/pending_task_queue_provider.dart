import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pending_task_queue_model.dart';

class PendingTaskQueueNotifier extends StateNotifier<PendingTaskQueueModel> {
  PendingTaskQueueNotifier() : super(const PendingTaskQueueModel(isLoading: true));

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

final pending_task_queueProvider = StateNotifierProvider<PendingTaskQueueNotifier, PendingTaskQueueModel>((ref) {
  return PendingTaskQueueNotifier()..loadData();
});
