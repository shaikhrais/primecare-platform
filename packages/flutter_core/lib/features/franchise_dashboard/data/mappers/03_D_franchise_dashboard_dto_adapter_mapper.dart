// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_franchise_dashboard_dto_adapter_dto.dart';

class FranchiseDashboardDtoAdapterMapper {
  static FranchiseDashboardDtoAdapterViewModel fromDto(FranchiseDashboardDtoAdapterDto dto) {
    return FranchiseDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

