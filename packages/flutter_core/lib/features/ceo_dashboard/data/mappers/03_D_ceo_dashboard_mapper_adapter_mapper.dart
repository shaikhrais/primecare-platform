// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_ceo_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_ceo_dashboard_mapper_adapter_dto.dart';

class CeoDashboardMapperAdapterMapper {
  static CeoDashboardMapperAdapterViewModel fromDto(CeoDashboardMapperAdapterDto dto) {
    return CeoDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ceoDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

