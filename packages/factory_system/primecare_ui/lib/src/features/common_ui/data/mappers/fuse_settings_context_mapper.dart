// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_settings_context_view_model.dart';
import '../dtos/fuse_settings_context_dto.dart';

class FuseSettingsContextMapper {
  static FuseSettingsContextViewModel fromDto(FuseSettingsContextDto dto) {
    return FuseSettingsContextViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseSettingsContext',
      metadata: dto.raw,
    );
  }
}
