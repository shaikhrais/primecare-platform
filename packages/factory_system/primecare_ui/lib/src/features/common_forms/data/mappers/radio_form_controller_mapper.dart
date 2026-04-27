// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/radio_form_controller_view_model.dart';
import '../dtos/radio_form_controller_dto.dart';

class RadioFormControllerMapper {
  static RadioFormControllerViewModel fromDto(RadioFormControllerDto dto) {
    return RadioFormControllerViewModel(
      title: dto.raw['title']?.toString() ?? 'radioFormController',
      metadata: dto.raw,
    );
  }
}
