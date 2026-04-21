// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_dashboard_mapper_view_model.dart';
import '../dtos/02_M_franchise_dashboard_mapper_dto.dart';

class FranchiseDashboardMapperMapper {
  static FranchiseDashboardMapperViewModel fromDto(FranchiseDashboardMapperDto dto) {
    return FranchiseDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseDashboardMapper',
      metadata: dto.raw,
    );
  }
}

