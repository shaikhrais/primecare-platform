// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_guest_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_guest_dashboard_mapper_adapter_dto.dart';

class GuestDashboardMapperAdapterMapper {
  static GuestDashboardMapperAdapterViewModel fromDto(GuestDashboardMapperAdapterDto dto) {
    return GuestDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'guestDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

