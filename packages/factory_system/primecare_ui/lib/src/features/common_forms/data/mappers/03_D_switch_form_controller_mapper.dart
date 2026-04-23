// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_switch_form_controller_view_model.dart';
import '../dtos/02_M_switch_form_controller_dto.dart';

class SwitchFormControllerMapper {
  static SwitchFormControllerViewModel fromDto(SwitchFormControllerDto dto) {
    return SwitchFormControllerViewModel(
      title: dto.raw['title']?.toString() ?? 'switchFormController',
      metadata: dto.raw,
    );
  }
}

