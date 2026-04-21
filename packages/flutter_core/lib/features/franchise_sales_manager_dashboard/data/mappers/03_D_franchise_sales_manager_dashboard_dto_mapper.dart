// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_sales_manager_dashboard_dto_view_model.dart';
import '../dtos/02_M_franchise_sales_manager_dashboard_dto_dto.dart';

class FranchiseSalesManagerDashboardDtoMapper {
  static FranchiseSalesManagerDashboardDtoViewModel fromDto(FranchiseSalesManagerDashboardDtoDto dto) {
    return FranchiseSalesManagerDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseSalesManagerDashboardDto',
      metadata: dto.raw,
    );
  }
}

