// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_franchise_dashboard_view_model.dart';
import '../dtos/02_M_franchise_dashboard_view_model_dto.dart';

class FranchiseDashboardViewModelMapper {
  static FranchiseDashboardViewModel fromDto(FranchiseDashboardViewModelDto dto) {
    return FranchiseDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

