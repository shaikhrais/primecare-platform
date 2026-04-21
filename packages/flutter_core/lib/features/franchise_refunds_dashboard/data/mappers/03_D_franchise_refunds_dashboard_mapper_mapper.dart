// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_refunds_dashboard_mapper_view_model.dart';
import '../dtos/02_M_franchise_refunds_dashboard_mapper_dto.dart';

class FranchiseRefundsDashboardMapperMapper {
  static FranchiseRefundsDashboardMapperViewModel fromDto(FranchiseRefundsDashboardMapperDto dto) {
    return FranchiseRefundsDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseRefundsDashboardMapper',
      metadata: dto.raw,
    );
  }
}

