// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_quick_panel_view_model.dart';
import '../dtos/02_M_quick_panel_dto.dart';

class QuickPanelMapper {
  static QuickPanelViewModel fromDto(QuickPanelDto dto) {
    return QuickPanelViewModel(
      title: dto.raw['title']?.toString() ?? 'quickPanel',
      metadata: dto.raw,
    );
  }
}
