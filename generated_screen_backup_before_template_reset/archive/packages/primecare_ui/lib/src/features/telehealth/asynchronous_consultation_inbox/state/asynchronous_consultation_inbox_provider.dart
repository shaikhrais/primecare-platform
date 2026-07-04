import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/asynchronous_consultation_inbox_model.dart';

class AsynchronousConsultationInboxNotifier extends StateNotifier<AsynchronousConsultationInboxModel> {
  AsynchronousConsultationInboxNotifier() : super(const AsynchronousConsultationInboxModel(isLoading: true));

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

final asynchronous_consultation_inboxProvider = StateNotifierProvider<AsynchronousConsultationInboxNotifier, AsynchronousConsultationInboxModel>((ref) {
  return AsynchronousConsultationInboxNotifier()..loadData();
});
