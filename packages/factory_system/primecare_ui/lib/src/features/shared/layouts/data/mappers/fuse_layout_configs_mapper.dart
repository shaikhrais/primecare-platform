// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_layout_configs_view_model.dart';
import '../dtos/fuse_layout_configs_dto.dart';

class FuseLayoutConfigsMapper {
  static FuseLayoutConfigsViewModel fromDto(FuseLayoutConfigsDto dto) {
    return FuseLayoutConfigsViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseLayoutConfigs',
      metadata: dto.raw,
    );
  }
}
