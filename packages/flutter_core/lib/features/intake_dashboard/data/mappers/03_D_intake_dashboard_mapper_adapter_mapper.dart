// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_intake_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_intake_dashboard_mapper_adapter_dto.dart';

class IntakeDashboardMapperAdapterMapper {
  static IntakeDashboardMapperAdapterViewModel fromDto(IntakeDashboardMapperAdapterDto dto) {
    return IntakeDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'intakeDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

