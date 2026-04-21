// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_family_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_family_dashboard_view_model_adapter_dto.dart';

class FamilyDashboardViewModelAdapterMapper {
  static FamilyDashboardViewModelAdapterViewModel fromDto(FamilyDashboardViewModelAdapterDto dto) {
    return FamilyDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'familyDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

