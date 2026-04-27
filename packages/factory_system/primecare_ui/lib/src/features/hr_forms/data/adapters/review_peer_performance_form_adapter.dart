// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/review_peer_performance_form_view_model.dart';
import '../mappers/review_peer_performance_form_mapper.dart';

class ReviewPeerPerformanceFormAdapter
    extends Notifier<ReviewPeerPerformanceFormViewModel> {
  @override
  ReviewPeerPerformanceFormViewModel build() {
    return ReviewPeerPerformanceFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = ReviewPeerPerformanceFormMapper.toDto(state);
      // ignore: avoid_print
      print('Reviewing peer performance: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error reviewing peer performance: \$e');
    }
  }
}

final reviewPeerPerformanceFormAdapterProvider =
    NotifierProvider<
      ReviewPeerPerformanceFormAdapter,
      ReviewPeerPerformanceFormViewModel
    >(() {
      return ReviewPeerPerformanceFormAdapter();
    });
