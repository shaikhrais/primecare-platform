import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_bdm_meetings_model.dart';

class RegionalBdmMeetingsNotifier extends StateNotifier<RegionalBdmMeetingsModel> {
  RegionalBdmMeetingsNotifier() : super(const RegionalBdmMeetingsModel(isLoading: true));

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

final regional_bdm_meetingsProvider = StateNotifierProvider<RegionalBdmMeetingsNotifier, RegionalBdmMeetingsModel>((ref) {
  return RegionalBdmMeetingsNotifier()..loadData();
});
