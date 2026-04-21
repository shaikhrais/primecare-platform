// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cto_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_cto_dashboard_mapper_adapter_dto.dart';

class CtoDashboardMapperAdapterMapper {
  static CtoDashboardMapperAdapterViewModel fromDto(CtoDashboardMapperAdapterDto dto) {
    return CtoDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'ctoDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

