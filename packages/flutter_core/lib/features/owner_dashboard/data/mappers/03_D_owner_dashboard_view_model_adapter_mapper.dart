// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_owner_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_owner_dashboard_view_model_adapter_dto.dart';

class OwnerDashboardViewModelAdapterMapper {
  static OwnerDashboardViewModelAdapterViewModel fromDto(OwnerDashboardViewModelAdapterDto dto) {
    return OwnerDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ownerDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

