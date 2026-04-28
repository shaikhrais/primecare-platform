// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/client_layout_view_model.dart';
import '../dtos/client_layout_dto.dart';

class ClientLayoutMapper {
  static ClientLayoutViewModel fromDto(ClientLayoutDto dto) {
    return ClientLayoutViewModel(
      title: dto.raw['title']?.toString() ?? 'clientLayout',
      metadata: dto.raw,
    );
  }
}
