// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_partnership_manager_dashboard_mapper_view_model.dart';
import '../dtos/02_M_partnership_manager_dashboard_mapper_dto.dart';

class PartnershipManagerDashboardMapperMapper {
  static PartnershipManagerDashboardMapperViewModel fromDto(PartnershipManagerDashboardMapperDto dto) {
    return PartnershipManagerDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'partnershipManagerDashboardMapper',
      metadata: dto.raw,
    );
  }
}

