// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_client_dashboard_adapter_view_model.dart';
import '../dtos/02_M_client_dashboard_adapter_dto.dart';

class ClientDashboardAdapterMapper {
  static ClientDashboardAdapterViewModel fromDto(ClientDashboardAdapterDto dto) {
    return ClientDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'clientDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

