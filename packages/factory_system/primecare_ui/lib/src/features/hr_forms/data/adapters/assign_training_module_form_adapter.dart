// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/assign_training_module_form_view_model.dart';
import '../mappers/assign_training_module_form_mapper.dart';

class AssignTrainingModuleFormAdapter
    extends Notifier<AssignTrainingModuleFormViewModel> {
  @override
  AssignTrainingModuleFormViewModel build() {
    return AssignTrainingModuleFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = AssignTrainingModuleFormMapper.toDto(state);
      // ignore: avoid_print
      print('Assigning training module: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error Assigning training module: \$e');
    }
  }
}

final assignTrainingModuleFormAdapterProvider =
    NotifierProvider<
      AssignTrainingModuleFormAdapter,
      AssignTrainingModuleFormViewModel
    >(() {
      return AssignTrainingModuleFormAdapter();
    });
