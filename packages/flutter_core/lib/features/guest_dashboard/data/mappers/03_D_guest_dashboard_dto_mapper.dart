// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_guest_dashboard_dto_view_model.dart';
import '../dtos/02_M_guest_dashboard_dto_dto.dart';

class GuestDashboardDtoMapper {
  static GuestDashboardDtoViewModel fromDto(GuestDashboardDtoDto dto) {
    return GuestDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'guestDashboardDto',
      metadata: dto.raw,
    );
  }
}

