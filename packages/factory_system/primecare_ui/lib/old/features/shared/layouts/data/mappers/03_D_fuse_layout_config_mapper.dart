// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_layout_config_view_model.dart';
import '../dtos/02_M_fuse_layout_config_dto.dart';

class FuseLayoutConfigMapper {
  static FuseLayoutConfigViewModel fromDto(FuseLayoutConfigDto dto) {
    return FuseLayoutConfigViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseLayoutConfig',
      metadata: dto.raw,
    );
  }
}
