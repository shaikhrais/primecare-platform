// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/quick_panel_toggle_button_view_model.dart';
import '../dtos/quick_panel_toggle_button_dto.dart';

class QuickPanelToggleButtonMapper {
  static QuickPanelToggleButtonViewModel fromDto(
    QuickPanelToggleButtonDto dto,
  ) {
    return QuickPanelToggleButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'quickPanelToggleButton',
      metadata: dto.raw,
    );
  }
}
