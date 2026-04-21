// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_reconciliation_dashboard_dto_view_model.dart';
import '../dtos/02_M_franchise_reconciliation_dashboard_dto_dto.dart';

class FranchiseReconciliationDashboardDtoMapper {
  static FranchiseReconciliationDashboardDtoViewModel fromDto(FranchiseReconciliationDashboardDtoDto dto) {
    return FranchiseReconciliationDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseReconciliationDashboardDto',
      metadata: dto.raw,
    );
  }
}

