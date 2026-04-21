// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_intake_dashboard_mapper_view_model.dart';
import '../dtos/02_M_intake_dashboard_mapper_dto.dart';

class IntakeDashboardMapperMapper {
  static IntakeDashboardMapperViewModel fromDto(IntakeDashboardMapperDto dto) {
    return IntakeDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'intakeDashboardMapper',
      metadata: dto.raw,
    );
  }
}

