// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_dashboard_dto_view_model.dart';
import '../dtos/02_M_franchise_dashboard_dto_dto.dart';

class FranchiseDashboardDtoMapper {
  static FranchiseDashboardDtoViewModel fromDto(FranchiseDashboardDtoDto dto) {
    return FranchiseDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseDashboardDto',
      metadata: dto.raw,
    );
  }
}

