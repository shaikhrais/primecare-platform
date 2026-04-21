// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_qa_dashboard_dto_view_model.dart';
import '../dtos/02_M_qa_dashboard_dto_dto.dart';

class QaDashboardDtoMapper {
  static QaDashboardDtoViewModel fromDto(QaDashboardDtoDto dto) {
    return QaDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'qaDashboardDto',
      metadata: dto.raw,
    );
  }
}

