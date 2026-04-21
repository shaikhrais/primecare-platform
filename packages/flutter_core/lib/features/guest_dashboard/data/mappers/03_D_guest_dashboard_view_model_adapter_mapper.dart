// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_guest_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_guest_dashboard_view_model_adapter_dto.dart';

class GuestDashboardViewModelAdapterMapper {
  static GuestDashboardViewModelAdapterViewModel fromDto(GuestDashboardViewModelAdapterDto dto) {
    return GuestDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'guestDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

