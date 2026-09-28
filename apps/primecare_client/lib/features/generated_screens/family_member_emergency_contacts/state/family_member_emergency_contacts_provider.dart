import 'package:flutter_riverpod/legacy.dart';
import '../models/family_member_emergency_contacts_model.dart';

class FamilyMemberEmergencyContactsNotifier extends StateNotifier<FamilyMemberEmergencyContactsModel> {
  FamilyMemberEmergencyContactsNotifier() : super(const FamilyMemberEmergencyContactsModel(isLoading: true));

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

final family_member_emergency_contactsProvider = StateNotifierProvider<FamilyMemberEmergencyContactsNotifier, FamilyMemberEmergencyContactsModel>((ref) {
  return FamilyMemberEmergencyContactsNotifier()..loadData();
});
