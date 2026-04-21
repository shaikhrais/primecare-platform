// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navbar_context_provider_view_model.dart';
import '../dtos/02_M_navbar_context_provider_dto.dart';

class NavbarContextProviderMapper {
  static NavbarContextProviderViewModel fromDto(NavbarContextProviderDto dto) {
    return NavbarContextProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarContextProvider',
      metadata: dto.raw,
    );
  }
}

