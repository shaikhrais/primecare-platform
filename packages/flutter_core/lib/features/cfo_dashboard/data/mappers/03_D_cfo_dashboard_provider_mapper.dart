// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cfo_dashboard_provider_view_model.dart';
import '../dtos/02_M_cfo_dashboard_provider_dto.dart';

class CfoDashboardProviderMapper {
  static CfoDashboardProviderViewModel fromDto(CfoDashboardProviderDto dto) {
    return CfoDashboardProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'cfoDashboardProvider',
      metadata: dto.raw,
    );
  }
}

