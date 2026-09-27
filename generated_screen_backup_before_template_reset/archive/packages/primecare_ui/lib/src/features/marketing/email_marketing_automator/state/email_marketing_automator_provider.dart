import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/email_marketing_automator_model.dart';

class EmailMarketingAutomatorNotifier extends StateNotifier<EmailMarketingAutomatorModel> {
  EmailMarketingAutomatorNotifier() : super(const EmailMarketingAutomatorModel(isLoading: true));

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

final email_marketing_automatorProvider = StateNotifierProvider<EmailMarketingAutomatorNotifier, EmailMarketingAutomatorModel>((ref) {
  return EmailMarketingAutomatorNotifier()..loadData();
});
