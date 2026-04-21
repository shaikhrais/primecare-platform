// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_refunds_dashboard_adapter_view_model.dart';
import '../dtos/02_M_franchise_refunds_dashboard_adapter_dto.dart';

class FranchiseRefundsDashboardAdapterMapper {
  static FranchiseRefundsDashboardAdapterViewModel fromDto(FranchiseRefundsDashboardAdapterDto dto) {
    return FranchiseRefundsDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseRefundsDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

