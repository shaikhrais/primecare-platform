// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_franchise_reports_dashboard_view_model.dart';
import '../dtos/02_M_franchise_reports_dashboard_view_model_dto.dart';

class FranchiseReportsDashboardViewModelMapper {
  static FranchiseReportsDashboardViewModel fromDto(FranchiseReportsDashboardViewModelDto dto) {
    return FranchiseReportsDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseReportsDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

