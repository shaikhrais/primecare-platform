// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/use_fuse_settings_view_model.dart';
import '../dtos/use_fuse_settings_dto.dart';

class UseFuseSettingsMapper {
  static UseFuseSettingsViewModel fromDto(UseFuseSettingsDto dto) {
    return UseFuseSettingsViewModel(
      title: dto.raw['title']?.toString() ?? 'useFuseSettings',
      metadata: dto.raw,
    );
  }
}
