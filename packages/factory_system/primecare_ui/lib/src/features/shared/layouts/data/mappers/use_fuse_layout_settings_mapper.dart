// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/use_fuse_layout_settings_view_model.dart';
import '../dtos/use_fuse_layout_settings_dto.dart';

class UseFuseLayoutSettingsMapper {
  static UseFuseLayoutSettingsViewModel fromDto(UseFuseLayoutSettingsDto dto) {
    return UseFuseLayoutSettingsViewModel(
      title: dto.raw['title']?.toString() ?? 'useFuseLayoutSettings',
      metadata: dto.raw,
    );
  }
}
