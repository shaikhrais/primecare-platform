// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_refunds_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_franchise_refunds_dashboard_dto_adapter_dto.dart';

class FranchiseRefundsDashboardDtoAdapterMapper {
  static FranchiseRefundsDashboardDtoAdapterViewModel fromDto(FranchiseRefundsDashboardDtoAdapterDto dto) {
    return FranchiseRefundsDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseRefundsDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

