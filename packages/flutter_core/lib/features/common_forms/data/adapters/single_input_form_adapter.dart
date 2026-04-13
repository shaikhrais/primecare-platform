import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/single_input_form_view_model.dart';
import '../mappers/single_input_form_mapper.dart';

class SingleInputFormAdapter extends Notifier<SingleInputFormViewModel> {
  @override
  SingleInputFormViewModel build() {
    return SingleInputFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future.delayed(const Duration(seconds: 1));
      
      final dto = SingleInputFormMapper.toDto(state);
      // ignore: avoid_print
      print('Submitting single input: ${dto.toJson()}');
      
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error Submitting single input: \$e');
    }
  }
}

final singleInputFormAdapterProvider =
    NotifierProvider<SingleInputFormAdapter, SingleInputFormViewModel>(() {
  return SingleInputFormAdapter();
});
