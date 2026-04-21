// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_franchise_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_franchise_dashboard_view_model_adapter_dto.dart';

class FranchiseDashboardViewModelAdapterMapper {
  static FranchiseDashboardViewModelAdapterViewModel fromDto(FranchiseDashboardViewModelAdapterDto dto) {
    return FranchiseDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

