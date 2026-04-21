// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_owner_dashboard_dto_view_model.dart';
import '../dtos/02_M_owner_dashboard_dto_dto.dart';

class OwnerDashboardDtoMapper {
  static OwnerDashboardDtoViewModel fromDto(OwnerDashboardDtoDto dto) {
    return OwnerDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'ownerDashboardDto',
      metadata: dto.raw,
    );
  }
}

