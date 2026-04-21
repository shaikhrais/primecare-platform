// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_settings_panel_view_model.dart';
import '../dtos/02_M_settings_panel_dto.dart';

class SettingsPanelMapper {
  static SettingsPanelViewModel fromDto(SettingsPanelDto dto) {
    return SettingsPanelViewModel(
      title: dto.raw['title']?.toString() ?? 'settingsPanel',
      metadata: dto.raw,
    );
  }
}

