// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/master_detail_layout_view_model.dart';
import '../dtos/master_detail_layout_dto.dart';

class MasterDetailLayoutMapper {
  static MasterDetailLayoutViewModel fromDto(MasterDetailLayoutDto dto) {
    return MasterDetailLayoutViewModel(
      title: dto.raw['title']?.toString() ?? 'masterDetailLayout',
      metadata: dto.raw,
    );
  }
}
