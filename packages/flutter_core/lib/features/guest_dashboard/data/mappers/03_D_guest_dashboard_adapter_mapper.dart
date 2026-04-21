// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_guest_dashboard_adapter_view_model.dart';
import '../dtos/02_M_guest_dashboard_adapter_dto.dart';

class GuestDashboardAdapterMapper {
  static GuestDashboardAdapterViewModel fromDto(GuestDashboardAdapterDto dto) {
    return GuestDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'guestDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

