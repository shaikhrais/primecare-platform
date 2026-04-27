// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_layout_settings_context_view_model.dart';
import '../dtos/fuse_layout_settings_context_dto.dart';

class FuseLayoutSettingsContextMapper {
  static FuseLayoutSettingsContextViewModel fromDto(
    FuseLayoutSettingsContextDto dto,
  ) {
    return FuseLayoutSettingsContextViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseLayoutSettingsContext',
      metadata: dto.raw,
    );
  }
}
