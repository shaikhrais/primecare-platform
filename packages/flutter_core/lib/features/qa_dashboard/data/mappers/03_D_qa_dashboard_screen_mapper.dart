// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_qa_dashboard_screen_view_model.dart';
import '../dtos/02_M_qa_dashboard_screen_dto.dart';

class QaDashboardScreenMapper {
  static QaDashboardScreenViewModel fromDto(QaDashboardScreenDto dto) {
    return QaDashboardScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'qaDashboardScreen',
      metadata: dto.raw,
    );
  }
}

