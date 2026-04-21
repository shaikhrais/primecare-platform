// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cfo_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_cfo_dashboard_mapper_adapter_dto.dart';

class CfoDashboardMapperAdapterMapper {
  static CfoDashboardMapperAdapterViewModel fromDto(CfoDashboardMapperAdapterDto dto) {
    return CfoDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'cfoDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

