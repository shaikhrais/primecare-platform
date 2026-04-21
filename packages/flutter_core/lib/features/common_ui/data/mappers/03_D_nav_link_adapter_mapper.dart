// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_nav_link_adapter_view_model.dart';
import '../dtos/02_M_nav_link_adapter_dto.dart';

class NavLinkAdapterMapper {
  static NavLinkAdapterViewModel fromDto(NavLinkAdapterDto dto) {
    return NavLinkAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'navLinkAdapter',
      metadata: dto.raw,
    );
  }
}

