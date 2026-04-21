// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_family_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_family_dashboard_dto_adapter_dto.dart';

class FamilyDashboardDtoAdapterMapper {
  static FamilyDashboardDtoAdapterViewModel fromDto(FamilyDashboardDtoAdapterDto dto) {
    return FamilyDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'familyDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

