// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_settings_provider_view_model.dart';
import '../dtos/02_M_fuse_settings_provider_dto.dart';

class FuseSettingsProviderMapper {
  static FuseSettingsProviderViewModel fromDto(FuseSettingsProviderDto dto) {
    return FuseSettingsProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseSettingsProvider',
      metadata: dto.raw,
    );
  }
}

