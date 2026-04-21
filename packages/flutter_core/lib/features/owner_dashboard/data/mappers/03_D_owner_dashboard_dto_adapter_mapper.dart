// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_owner_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_owner_dashboard_dto_adapter_dto.dart';

class OwnerDashboardDtoAdapterMapper {
  static OwnerDashboardDtoAdapterViewModel fromDto(OwnerDashboardDtoAdapterDto dto) {
    return OwnerDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ownerDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

