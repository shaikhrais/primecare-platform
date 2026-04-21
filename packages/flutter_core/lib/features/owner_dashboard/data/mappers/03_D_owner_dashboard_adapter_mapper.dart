// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_owner_dashboard_adapter_view_model.dart';
import '../dtos/02_M_owner_dashboard_adapter_dto.dart';

class OwnerDashboardAdapterMapper {
  static OwnerDashboardAdapterViewModel fromDto(OwnerDashboardAdapterDto dto) {
    return OwnerDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ownerDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

