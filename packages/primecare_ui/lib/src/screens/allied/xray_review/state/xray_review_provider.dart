import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/xray_review_model.dart';

class XrayReviewNotifier extends StateNotifier<XrayReviewModel> {
  XrayReviewNotifier() : super(const XrayReviewModel(isLoading: true));

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

final xray_reviewProvider = StateNotifierProvider<XrayReviewNotifier, XrayReviewModel>((ref) {
  return XrayReviewNotifier()..loadData();
});
