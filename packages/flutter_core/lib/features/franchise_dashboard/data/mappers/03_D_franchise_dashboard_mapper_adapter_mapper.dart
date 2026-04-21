// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_franchise_dashboard_mapper_adapter_dto.dart';

class FranchiseDashboardMapperAdapterMapper {
  static FranchiseDashboardMapperAdapterViewModel fromDto(FranchiseDashboardMapperAdapterDto dto) {
    return FranchiseDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

