// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_guest_dashboard_mapper_view_model.dart';
import '../dtos/02_M_guest_dashboard_mapper_dto.dart';

class GuestDashboardMapperMapper {
  static GuestDashboardMapperViewModel fromDto(GuestDashboardMapperDto dto) {
    return GuestDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'guestDashboardMapper',
      metadata: dto.raw,
    );
  }
}

