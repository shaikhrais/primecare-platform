import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/responsive_preview_model.dart';

class ResponsivePreviewNotifier extends StateNotifier<ResponsivePreviewModel> {
  ResponsivePreviewNotifier() : super(const ResponsivePreviewModel(isLoading: true));

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

final responsive_previewProvider = StateNotifierProvider<ResponsivePreviewNotifier, ResponsivePreviewModel>((ref) {
  return ResponsivePreviewNotifier()..loadData();
});
