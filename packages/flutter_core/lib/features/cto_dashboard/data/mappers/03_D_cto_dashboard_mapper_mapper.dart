// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cto_dashboard_mapper_view_model.dart';
import '../dtos/02_M_cto_dashboard_mapper_dto.dart';

class CtoDashboardMapperMapper {
  static CtoDashboardMapperViewModel fromDto(CtoDashboardMapperDto dto) {
    return CtoDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'ctoDashboardMapper',
      metadata: dto.raw,
    );
  }
}

