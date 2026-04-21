// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_settings_viewer_dialog_view_model.dart';
import '../dtos/02_M_fuse_settings_viewer_dialog_dto.dart';

class FuseSettingsViewerDialogMapper {
  static FuseSettingsViewerDialogViewModel fromDto(FuseSettingsViewerDialogDto dto) {
    return FuseSettingsViewerDialogViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseSettingsViewerDialog',
      metadata: dto.raw,
    );
  }
}

