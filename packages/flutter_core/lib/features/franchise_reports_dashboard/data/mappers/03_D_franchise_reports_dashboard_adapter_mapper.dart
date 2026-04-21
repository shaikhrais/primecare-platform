// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_reports_dashboard_adapter_view_model.dart';
import '../dtos/02_M_franchise_reports_dashboard_adapter_dto.dart';

class FranchiseReportsDashboardAdapterMapper {
  static FranchiseReportsDashboardAdapterViewModel fromDto(FranchiseReportsDashboardAdapterDto dto) {
    return FranchiseReportsDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseReportsDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

