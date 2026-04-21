// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_sales_manager_dashboard_mapper_view_model.dart';
import '../dtos/02_M_franchise_sales_manager_dashboard_mapper_dto.dart';

class FranchiseSalesManagerDashboardMapperMapper {
  static FranchiseSalesManagerDashboardMapperViewModel fromDto(FranchiseSalesManagerDashboardMapperDto dto) {
    return FranchiseSalesManagerDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseSalesManagerDashboardMapper',
      metadata: dto.raw,
    );
  }
}

