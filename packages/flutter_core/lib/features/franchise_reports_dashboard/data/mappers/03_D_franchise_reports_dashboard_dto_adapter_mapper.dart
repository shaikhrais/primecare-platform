// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_reports_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_franchise_reports_dashboard_dto_adapter_dto.dart';

class FranchiseReportsDashboardDtoAdapterMapper {
  static FranchiseReportsDashboardDtoAdapterViewModel fromDto(FranchiseReportsDashboardDtoAdapterDto dto) {
    return FranchiseReportsDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseReportsDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

