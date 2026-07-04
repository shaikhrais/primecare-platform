import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/response_bot_audit_model.dart';

class ResponseBotAuditNotifier extends StateNotifier<ResponseBotAuditModel> {
  ResponseBotAuditNotifier() : super(const ResponseBotAuditModel(isLoading: true));

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

final response_bot_auditProvider = StateNotifierProvider<ResponseBotAuditNotifier, ResponseBotAuditModel>((ref) {
  return ResponseBotAuditNotifier()..loadData();
});
