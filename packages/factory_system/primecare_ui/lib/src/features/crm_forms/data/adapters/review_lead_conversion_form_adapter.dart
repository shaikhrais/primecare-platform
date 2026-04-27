// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/review_lead_conversion_form_view_model.dart';
import '../mappers/review_lead_conversion_form_mapper.dart';

class ReviewLeadConversionFormAdapter
    extends Notifier<ReviewLeadConversionFormViewModel> {
  @override
  ReviewLeadConversionFormViewModel build() {
    return ReviewLeadConversionFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = ReviewLeadConversionFormMapper.toDto(state);
      // ignore: avoid_print
      print('Submitting Review Lead Conversion: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error Submitting Review Lead Conversion: \$e');
    }
  }
}

final reviewLeadConversionFormAdapterProvider =
    NotifierProvider<
      ReviewLeadConversionFormAdapter,
      ReviewLeadConversionFormViewModel
    >(() {
      return ReviewLeadConversionFormAdapter();
    });
