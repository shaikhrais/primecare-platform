// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_refunds_dashboard_dto_view_model.dart';
import '../dtos/02_M_franchise_refunds_dashboard_dto_dto.dart';

class FranchiseRefundsDashboardDtoMapper {
  static FranchiseRefundsDashboardDtoViewModel fromDto(FranchiseRefundsDashboardDtoDto dto) {
    return FranchiseRefundsDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseRefundsDashboardDto',
      metadata: dto.raw,
    );
  }
}

