// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_qa_dashboard_mapper_view_model.dart';
import '../dtos/02_M_qa_dashboard_mapper_dto.dart';

class QaDashboardMapperMapper {
  static QaDashboardMapperViewModel fromDto(QaDashboardMapperDto dto) {
    return QaDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'qaDashboardMapper',
      metadata: dto.raw,
    );
  }
}

