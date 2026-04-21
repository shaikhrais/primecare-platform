// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_reports_dashboard_mapper_view_model.dart';
import '../dtos/02_M_franchise_reports_dashboard_mapper_dto.dart';

class FranchiseReportsDashboardMapperMapper {
  static FranchiseReportsDashboardMapperViewModel fromDto(FranchiseReportsDashboardMapperDto dto) {
    return FranchiseReportsDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseReportsDashboardMapper',
      metadata: dto.raw,
    );
  }
}

