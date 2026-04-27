// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/assign_training_module_form_view_model.dart';
import '../dtos/assign_training_module_form_dto.dart';

class AssignTrainingModuleFormMapper {
  static AssignTrainingModuleFormViewModel fromDto(
    AssignTrainingModuleFormDto dto,
  ) {
    return AssignTrainingModuleFormViewModel(
      title: dto.raw['title']?.toString() ?? 'assignTrainingModuleForm',
      metadata: dto.raw,
    );
  }
}
