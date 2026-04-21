// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_coo_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_coo_dashboard_mapper_adapter_dto.dart';

class CooDashboardMapperAdapterMapper {
  static CooDashboardMapperAdapterViewModel fromDto(CooDashboardMapperAdapterDto dto) {
    return CooDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'cooDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

