// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_family_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_family_dashboard_mapper_adapter_dto.dart';

class FamilyDashboardMapperAdapterMapper {
  static FamilyDashboardMapperAdapterViewModel fromDto(FamilyDashboardMapperAdapterDto dto) {
    return FamilyDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'familyDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

