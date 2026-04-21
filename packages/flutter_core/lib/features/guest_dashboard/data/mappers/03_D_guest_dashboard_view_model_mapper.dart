// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_guest_dashboard_view_model.dart';
import '../dtos/02_M_guest_dashboard_view_model_dto.dart';

class GuestDashboardViewModelMapper {
  static GuestDashboardViewModel fromDto(GuestDashboardViewModelDto dto) {
    return GuestDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'guestDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

