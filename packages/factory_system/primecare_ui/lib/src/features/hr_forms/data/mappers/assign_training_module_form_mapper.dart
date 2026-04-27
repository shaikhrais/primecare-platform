// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/assign_training_module_form_view_model.dart';
import '../dtos/assign_training_module_form_dto.dart';

class AssignTrainingModuleFormMapper {
  static AssignTrainingModuleFormViewModel toViewModel(
    AssignTrainingModuleFormDto dto,
  ) {
    return AssignTrainingModuleFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static AssignTrainingModuleFormDto toDto(
    AssignTrainingModuleFormViewModel viewModel,
  ) {
    return AssignTrainingModuleFormDto(rawData: viewModel.data);
  }
}
