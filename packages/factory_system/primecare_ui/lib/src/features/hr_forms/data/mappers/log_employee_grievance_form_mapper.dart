// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/log_employee_grievance_form_view_model.dart';
import '../dtos/log_employee_grievance_form_dto.dart';

class LogEmployeeGrievanceFormMapper {
  static LogEmployeeGrievanceFormViewModel toViewModel(
    LogEmployeeGrievanceFormDto dto,
  ) {
    return LogEmployeeGrievanceFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static LogEmployeeGrievanceFormDto toDto(
    LogEmployeeGrievanceFormViewModel viewModel,
  ) {
    return LogEmployeeGrievanceFormDto(rawData: viewModel.data);
  }
}
