// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_partnership_manager_dashboard_adapter_view_model.dart';
import '../dtos/02_M_partnership_manager_dashboard_adapter_dto.dart';

class PartnershipManagerDashboardAdapterMapper {
  static PartnershipManagerDashboardAdapterViewModel fromDto(PartnershipManagerDashboardAdapterDto dto) {
    return PartnershipManagerDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'partnershipManagerDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

