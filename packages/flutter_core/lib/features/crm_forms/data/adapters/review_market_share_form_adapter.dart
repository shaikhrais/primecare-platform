import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/review_market_share_form_view_model.dart';
import '../mappers/review_market_share_form_mapper.dart';

class ReviewMarketShareFormAdapter
    extends Notifier<ReviewMarketShareFormViewModel> {
  @override
  ReviewMarketShareFormViewModel build() {
    return ReviewMarketShareFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future.delayed(const Duration(seconds: 1));

      final dto = ReviewMarketShareFormMapper.toDto(state);
      // ignore: avoid_print
      print('Submitting Review Market Share: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error Submitting Review Market Share: \$e');
    }
  }
}

final reviewMarketShareFormAdapterProvider =
    NotifierProvider<
      ReviewMarketShareFormAdapter,
      ReviewMarketShareFormViewModel
    >(() {
      return ReviewMarketShareFormAdapter();
    });
