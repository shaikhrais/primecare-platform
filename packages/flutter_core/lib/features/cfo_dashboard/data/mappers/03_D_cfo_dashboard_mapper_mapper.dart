// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cfo_dashboard_mapper_view_model.dart';
import '../dtos/02_M_cfo_dashboard_mapper_dto.dart';

class CfoDashboardMapperMapper {
  static CfoDashboardMapperViewModel fromDto(CfoDashboardMapperDto dto) {
    return CfoDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'cfoDashboardMapper',
      metadata: dto.raw,
    );
  }
}

