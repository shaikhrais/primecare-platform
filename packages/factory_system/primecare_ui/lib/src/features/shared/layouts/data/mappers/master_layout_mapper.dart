// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/master_layout_view_model.dart';
import '../dtos/master_layout_dto.dart';

class MasterLayoutMapper {
  static MasterLayoutViewModel fromDto(MasterLayoutDto dto) {
    return MasterLayoutViewModel(
      title: dto.raw['title']?.toString() ?? 'masterLayout',
      metadata: dto.raw,
    );
  }
}
