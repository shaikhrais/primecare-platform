// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_guest_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_guest_dashboard_dto_adapter_dto.dart';

class GuestDashboardDtoAdapterMapper {
  static GuestDashboardDtoAdapterViewModel fromDto(GuestDashboardDtoAdapterDto dto) {
    return GuestDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'guestDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

