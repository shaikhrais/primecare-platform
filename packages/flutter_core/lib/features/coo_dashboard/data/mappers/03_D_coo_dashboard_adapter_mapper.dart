// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_coo_dashboard_adapter_view_model.dart';
import '../dtos/02_M_coo_dashboard_adapter_dto.dart';

class CooDashboardAdapterMapper {
  static CooDashboardAdapterViewModel fromDto(CooDashboardAdapterDto dto) {
    return CooDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'cooDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

