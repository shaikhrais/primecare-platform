// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_ceo_dashboard_provider_view_model.dart';
import '../dtos/02_M_ceo_dashboard_provider_dto.dart';

class CeoDashboardProviderMapper {
  static CeoDashboardProviderViewModel fromDto(CeoDashboardProviderDto dto) {
    return CeoDashboardProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'ceoDashboardProvider',
      metadata: dto.raw,
    );
  }
}

