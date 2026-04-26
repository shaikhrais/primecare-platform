// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_settings_context_view_model.dart';
import '../dtos/02_M_fuse_settings_context_dto.dart';

class FuseSettingsContextMapper {
  static FuseSettingsContextViewModel fromDto(FuseSettingsContextDto dto) {
    return FuseSettingsContextViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseSettingsContext',
      metadata: dto.raw,
    );
  }
}
