import '../../domain/models/single_input_form_view_model.dart';
import '../dtos/single_input_form_dto.dart';

class SingleInputFormMapper {
  static SingleInputFormViewModel toViewModel(SingleInputFormDto dto) {
    return SingleInputFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static SingleInputFormDto toDto(SingleInputFormViewModel viewModel) {
    return SingleInputFormDto(
      rawData: viewModel.data,
    );
  }
}
