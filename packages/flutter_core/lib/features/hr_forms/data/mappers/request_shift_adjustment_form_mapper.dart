import '../../domain/models/request_shift_adjustment_form_view_model.dart';
import '../dtos/request_shift_adjustment_form_dto.dart';

class RequestShiftAdjustmentFormMapper {
  static RequestShiftAdjustmentFormViewModel toViewModel(
    RequestShiftAdjustmentFormDto dto,
  ) {
    return RequestShiftAdjustmentFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static RequestShiftAdjustmentFormDto toDto(
    RequestShiftAdjustmentFormViewModel viewModel,
  ) {
    return RequestShiftAdjustmentFormDto(rawData: viewModel.data);
  }
}
