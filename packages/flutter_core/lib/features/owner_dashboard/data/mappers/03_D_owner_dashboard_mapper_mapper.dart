// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_owner_dashboard_mapper_view_model.dart';
import '../dtos/02_M_owner_dashboard_mapper_dto.dart';

class OwnerDashboardMapperMapper {
  static OwnerDashboardMapperViewModel fromDto(OwnerDashboardMapperDto dto) {
    return OwnerDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'ownerDashboardMapper',
      metadata: dto.raw,
    );
  }
}

