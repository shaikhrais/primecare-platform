import 'package:flutter_riverpod/legacy.dart';
import '../models/family_emergency_contacts_model.dart';

class FamilyEmergencyContactsNotifier extends StateNotifier<FamilyEmergencyContactsModel> {
  FamilyEmergencyContactsNotifier() : super(const FamilyEmergencyContactsModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final family_emergency_contactsProvider = StateNotifierProvider<FamilyEmergencyContactsNotifier, FamilyEmergencyContactsModel>((ref) {
  return FamilyEmergencyContactsNotifier()..loadData();
});
