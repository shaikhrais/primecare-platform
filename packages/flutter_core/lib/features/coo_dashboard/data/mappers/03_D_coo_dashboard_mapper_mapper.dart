// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_coo_dashboard_mapper_view_model.dart';
import '../dtos/02_M_coo_dashboard_mapper_dto.dart';

class CooDashboardMapperMapper {
  static CooDashboardMapperViewModel fromDto(CooDashboardMapperDto dto) {
    return CooDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'cooDashboardMapper',
      metadata: dto.raw,
    );
  }
}

