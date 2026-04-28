// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/align_center_icon_view_model.dart';
import '../dtos/align_center_icon_dto.dart';

class AlignCenterIconMapper {
  static AlignCenterIconViewModel fromDto(AlignCenterIconDto dto) {
    return AlignCenterIconViewModel(
      title: dto.raw['title']?.toString() ?? 'alignCenterIcon',
      metadata: dto.raw,
    );
  }
}
