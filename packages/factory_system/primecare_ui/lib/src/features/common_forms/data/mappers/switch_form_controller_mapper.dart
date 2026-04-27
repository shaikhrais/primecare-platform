// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/switch_form_controller_view_model.dart';
import '../dtos/switch_form_controller_dto.dart';

class SwitchFormControllerMapper {
  static SwitchFormControllerViewModel fromDto(SwitchFormControllerDto dto) {
    return SwitchFormControllerViewModel(
      title: dto.raw['title']?.toString() ?? 'switchFormController',
      metadata: dto.raw,
    );
  }
}
