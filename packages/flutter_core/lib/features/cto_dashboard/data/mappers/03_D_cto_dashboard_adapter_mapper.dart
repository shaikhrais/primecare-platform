// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cto_dashboard_adapter_view_model.dart';
import '../dtos/02_M_cto_dashboard_adapter_dto.dart';

class CtoDashboardAdapterMapper {
  static CtoDashboardAdapterViewModel fromDto(CtoDashboardAdapterDto dto) {
    return CtoDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ctoDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

