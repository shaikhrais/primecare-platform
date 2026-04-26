// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_radio_form_controller_view_model.dart';
import '../dtos/02_M_radio_form_controller_dto.dart';

class RadioFormControllerMapper {
  static RadioFormControllerViewModel fromDto(RadioFormControllerDto dto) {
    return RadioFormControllerViewModel(
      title: dto.raw['title']?.toString() ?? 'radioFormController',
      metadata: dto.raw,
    );
  }
}
