// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_ceo_dashboard_adapter_view_model.dart';
import '../dtos/02_M_ceo_dashboard_adapter_dto.dart';

class CeoDashboardAdapterMapper {
  static CeoDashboardAdapterViewModel fromDto(CeoDashboardAdapterDto dto) {
    return CeoDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ceoDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

