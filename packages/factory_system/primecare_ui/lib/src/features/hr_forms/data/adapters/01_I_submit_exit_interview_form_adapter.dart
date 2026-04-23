// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/02_M_submit_exit_interview_form_view_model.dart';
import '../mappers/03_D_submit_exit_interview_form_mapper.dart';

class SubmitExitInterviewFormAdapter
    extends Notifier<SubmitExitInterviewFormViewModel> {
  @override
  SubmitExitInterviewFormViewModel build() {
    return SubmitExitInterviewFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = SubmitExitInterviewFormMapper.toDto(state);
      // ignore: avoid_print
      print('Submitting exit interview: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error Submitting exit interview: \$e');
    }
  }
}

final submitExitInterviewFormAdapterProvider =
    NotifierProvider<
      SubmitExitInterviewFormAdapter,
      SubmitExitInterviewFormViewModel
    >(() {
      return SubmitExitInterviewFormAdapter();
    });
