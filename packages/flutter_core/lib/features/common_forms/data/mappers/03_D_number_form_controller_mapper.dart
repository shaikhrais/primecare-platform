// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_number_form_controller_view_model.dart';
import '../dtos/02_M_number_form_controller_dto.dart';

class NumberFormControllerMapper {
  static NumberFormControllerViewModel fromDto(NumberFormControllerDto dto) {
    return NumberFormControllerViewModel(
      title: dto.raw['title']?.toString() ?? 'numberFormController',
      metadata: dto.raw,
    );
  }
}

