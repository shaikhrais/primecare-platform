// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_owner_dashboard_adapter_view_model.dart';
import '../dtos/02_M_franchise_owner_dashboard_adapter_dto.dart';

class FranchiseOwnerDashboardAdapterMapper {
  static FranchiseOwnerDashboardAdapterViewModel fromDto(FranchiseOwnerDashboardAdapterDto dto) {
    return FranchiseOwnerDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseOwnerDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

