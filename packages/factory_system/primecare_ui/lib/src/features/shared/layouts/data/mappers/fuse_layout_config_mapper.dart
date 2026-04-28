// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/fuse_layout_config_view_model.dart';
import '../dtos/fuse_layout_config_dto.dart';

class FuseLayoutConfigMapper {
  static FuseLayoutConfigViewModel fromDto(FuseLayoutConfigDto dto) {
    return FuseLayoutConfigViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseLayoutConfig',
      metadata: dto.raw,
    );
  }
}
