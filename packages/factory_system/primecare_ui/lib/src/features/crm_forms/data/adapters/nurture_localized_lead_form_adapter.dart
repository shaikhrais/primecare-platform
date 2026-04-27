// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/nurture_localized_lead_form_view_model.dart';
import '../mappers/nurture_localized_lead_form_mapper.dart';

class NurtureLocalizedLeadFormAdapter
    extends Notifier<NurtureLocalizedLeadFormViewModel> {
  @override
  NurtureLocalizedLeadFormViewModel build() {
    return NurtureLocalizedLeadFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = NurtureLocalizedLeadFormMapper.toDto(state);
      // ignore: avoid_print
      print('Submitting Nurture Localized Lead: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error Submitting Nurture Localized Lead: \$e');
    }
  }
}

final nurtureLocalizedLeadFormAdapterProvider =
    NotifierProvider<
      NurtureLocalizedLeadFormAdapter,
      NurtureLocalizedLeadFormViewModel
    >(() {
      return NurtureLocalizedLeadFormAdapter();
    });
