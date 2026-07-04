import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/emergency_contacts_model.dart';

class EmergencyContactsNotifier extends StateNotifier<EmergencyContactsModel> {
  EmergencyContactsNotifier() : super(const EmergencyContactsModel(isLoading: true));

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

final emergency_contactsProvider = StateNotifierProvider<EmergencyContactsNotifier, EmergencyContactsModel>((ref) {
  return EmergencyContactsNotifier()..loadData();
});
