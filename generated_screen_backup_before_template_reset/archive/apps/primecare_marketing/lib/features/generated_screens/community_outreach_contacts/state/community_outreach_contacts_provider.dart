import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/community_outreach_contacts_model.dart';

class CommunityOutreachContactsNotifier extends StateNotifier<CommunityOutreachContactsModel> {
  CommunityOutreachContactsNotifier() : super(const CommunityOutreachContactsModel(isLoading: true));

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

final community_outreach_contactsProvider = StateNotifierProvider<CommunityOutreachContactsNotifier, CommunityOutreachContactsModel>((ref) {
  return CommunityOutreachContactsNotifier()..loadData();
});
