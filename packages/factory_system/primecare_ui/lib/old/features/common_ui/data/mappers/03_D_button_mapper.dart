// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_button_view_model.dart';
import '../dtos/02_M_button_dto.dart';

class ButtonMapper {
  static ButtonViewModel fromDto(ButtonDto dto) {
    return ButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'button',
      metadata: dto.raw,
    );
  }
}
