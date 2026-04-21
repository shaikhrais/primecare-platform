// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_reports_dashboard_dto_view_model.dart';
import '../dtos/02_M_franchise_reports_dashboard_dto_dto.dart';

class FranchiseReportsDashboardDtoMapper {
  static FranchiseReportsDashboardDtoViewModel fromDto(FranchiseReportsDashboardDtoDto dto) {
    return FranchiseReportsDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseReportsDashboardDto',
      metadata: dto.raw,
    );
  }
}

