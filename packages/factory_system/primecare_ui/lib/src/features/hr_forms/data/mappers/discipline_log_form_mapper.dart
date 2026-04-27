// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/discipline_log_form_view_model.dart';
import '../dtos/discipline_log_form_dto.dart';

class DisciplineLogFormMapper {
  static DisciplineLogFormViewModel toViewModel(DisciplineLogFormDto dto) {
    return DisciplineLogFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static DisciplineLogFormDto toDto(DisciplineLogFormViewModel viewModel) {
    return DisciplineLogFormDto(rawData: viewModel.data);
  }
}
