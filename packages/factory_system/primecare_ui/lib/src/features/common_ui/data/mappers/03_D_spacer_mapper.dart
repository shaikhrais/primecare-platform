// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_spacer_view_model.dart';
import '../dtos/02_M_spacer_dto.dart';

class SpacerMapper {
  static SpacerViewModel fromDto(SpacerDto dto) {
    return SpacerViewModel(
      title: dto.raw['title']?.toString() ?? 'spacer',
      metadata: dto.raw,
    );
  }
}

