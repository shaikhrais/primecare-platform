// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_coo_dashboard_provider_view_model.dart';
import '../dtos/02_M_coo_dashboard_provider_dto.dart';

class CooDashboardProviderMapper {
  static CooDashboardProviderViewModel fromDto(CooDashboardProviderDto dto) {
    return CooDashboardProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'cooDashboardProvider',
      metadata: dto.raw,
    );
  }
}

