// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cfo_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_cfo_dashboard_dto_adapter_dto.dart';

class CfoDashboardDtoAdapterMapper {
  static CfoDashboardDtoAdapterViewModel fromDto(CfoDashboardDtoAdapterDto dto) {
    return CfoDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'cfoDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

