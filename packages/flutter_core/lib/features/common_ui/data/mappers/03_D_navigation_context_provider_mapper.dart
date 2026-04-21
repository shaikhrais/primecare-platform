// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navigation_context_provider_view_model.dart';
import '../dtos/02_M_navigation_context_provider_dto.dart';

class NavigationContextProviderMapper {
  static NavigationContextProviderViewModel fromDto(NavigationContextProviderDto dto) {
    return NavigationContextProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'navigationContextProvider',
      metadata: dto.raw,
    );
  }
}

