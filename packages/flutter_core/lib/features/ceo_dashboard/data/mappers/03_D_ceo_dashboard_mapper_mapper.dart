// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_ceo_dashboard_mapper_view_model.dart';
import '../dtos/02_M_ceo_dashboard_mapper_dto.dart';

class CeoDashboardMapperMapper {
  static CeoDashboardMapperViewModel fromDto(CeoDashboardMapperDto dto) {
    return CeoDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'ceoDashboardMapper',
      metadata: dto.raw,
    );
  }
}

