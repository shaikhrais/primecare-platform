// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_client_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_client_dashboard_view_model_adapter_dto.dart';

class ClientDashboardViewModelAdapterMapper {
  static ClientDashboardViewModelAdapterViewModel fromDto(ClientDashboardViewModelAdapterDto dto) {
    return ClientDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'clientDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

