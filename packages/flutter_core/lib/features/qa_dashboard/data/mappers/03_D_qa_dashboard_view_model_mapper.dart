// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_qa_dashboard_view_model.dart';
import '../dtos/02_M_qa_dashboard_view_model_dto.dart';

class QaDashboardViewModelMapper {
  static QaDashboardViewModel fromDto(QaDashboardViewModelDto dto) {
    return QaDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'qaDashboardViewModel',
      metadata: dto.raw,
    );
  }
}
