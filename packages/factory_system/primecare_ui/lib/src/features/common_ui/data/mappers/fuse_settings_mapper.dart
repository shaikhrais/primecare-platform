// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_settings_view_model.dart';
import '../dtos/fuse_settings_dto.dart';

class FuseSettingsMapper {
  static FuseSettingsViewModel fromDto(FuseSettingsDto dto) {
    return FuseSettingsViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseSettings',
      metadata: dto.raw,
    );
  }
}
