// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_dashboard_adapter_view_model.dart';
import '../dtos/02_M_franchise_dashboard_adapter_dto.dart';

class FranchiseDashboardAdapterMapper {
  static FranchiseDashboardAdapterViewModel fromDto(FranchiseDashboardAdapterDto dto) {
    return FranchiseDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

