// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_quick_panel_context_provider_view_model.dart';
import '../dtos/02_M_quick_panel_context_provider_dto.dart';

class QuickPanelContextProviderMapper {
  static QuickPanelContextProviderViewModel fromDto(QuickPanelContextProviderDto dto) {
    return QuickPanelContextProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'quickPanelContextProvider',
      metadata: dto.raw,
    );
  }
}

