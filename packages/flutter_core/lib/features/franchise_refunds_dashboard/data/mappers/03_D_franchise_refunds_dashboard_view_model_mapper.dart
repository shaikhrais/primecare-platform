// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_franchise_refunds_dashboard_view_model.dart';
import '../dtos/02_M_franchise_refunds_dashboard_view_model_dto.dart';

class FranchiseRefundsDashboardViewModelMapper {
  static FranchiseRefundsDashboardViewModel fromDto(FranchiseRefundsDashboardViewModelDto dto) {
    return FranchiseRefundsDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseRefundsDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

