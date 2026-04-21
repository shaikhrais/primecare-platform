// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_family_dashboard_adapter_view_model.dart';
import '../dtos/02_M_family_dashboard_adapter_dto.dart';

class FamilyDashboardAdapterMapper {
  static FamilyDashboardAdapterViewModel fromDto(FamilyDashboardAdapterDto dto) {
    return FamilyDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'familyDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

