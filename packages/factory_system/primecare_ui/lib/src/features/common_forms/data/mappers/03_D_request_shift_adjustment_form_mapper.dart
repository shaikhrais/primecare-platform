// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_request_shift_adjustment_form_view_model.dart';
import '../dtos/02_M_request_shift_adjustment_form_dto.dart';

class RequestShiftAdjustmentFormMapper {
  static RequestShiftAdjustmentFormViewModel fromDto(RequestShiftAdjustmentFormDto dto) {
    return RequestShiftAdjustmentFormViewModel(
      title: dto.raw['title']?.toString() ?? 'requestShiftAdjustmentForm',
      metadata: dto.raw,
    );
  }
}

