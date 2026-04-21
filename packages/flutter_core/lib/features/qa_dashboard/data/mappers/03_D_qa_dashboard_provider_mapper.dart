// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_qa_dashboard_provider_view_model.dart';
import '../dtos/02_M_qa_dashboard_provider_dto.dart';

class QaDashboardProviderMapper {
  static QaDashboardProviderViewModel fromDto(QaDashboardProviderDto dto) {
    return QaDashboardProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'qaDashboardProvider',
      metadata: dto.raw,
    );
  }
}

