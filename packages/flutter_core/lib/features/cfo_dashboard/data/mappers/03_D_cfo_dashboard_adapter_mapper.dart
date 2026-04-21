// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cfo_dashboard_adapter_view_model.dart';
import '../dtos/02_M_cfo_dashboard_adapter_dto.dart';

class CfoDashboardAdapterMapper {
  static CfoDashboardAdapterViewModel fromDto(CfoDashboardAdapterDto dto) {
    return CfoDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'cfoDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

