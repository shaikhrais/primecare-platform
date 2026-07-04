import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/surgical_video_archive_model.dart';

class SurgicalVideoArchiveNotifier extends StateNotifier<SurgicalVideoArchiveModel> {
  SurgicalVideoArchiveNotifier() : super(const SurgicalVideoArchiveModel(isLoading: true));

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

final surgical_video_archiveProvider = StateNotifierProvider<SurgicalVideoArchiveNotifier, SurgicalVideoArchiveModel>((ref) {
  return SurgicalVideoArchiveNotifier()..loadData();
});
