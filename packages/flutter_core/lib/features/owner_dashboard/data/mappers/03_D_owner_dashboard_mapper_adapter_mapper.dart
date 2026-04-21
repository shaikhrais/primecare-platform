// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_owner_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_owner_dashboard_mapper_adapter_dto.dart';

class OwnerDashboardMapperAdapterMapper {
  static OwnerDashboardMapperAdapterViewModel fromDto(OwnerDashboardMapperAdapterDto dto) {
    return OwnerDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ownerDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

