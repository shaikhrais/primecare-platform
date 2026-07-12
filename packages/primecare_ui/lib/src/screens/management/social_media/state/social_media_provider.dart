import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/social_media_model.dart';

class SocialMediaNotifier extends StateNotifier<SocialMediaModel> {
  SocialMediaNotifier() : super(const SocialMediaModel(isLoading: true));

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

final social_mediaProvider = StateNotifierProvider<SocialMediaNotifier, SocialMediaModel>((ref) {
  return SocialMediaNotifier()..loadData();
});
