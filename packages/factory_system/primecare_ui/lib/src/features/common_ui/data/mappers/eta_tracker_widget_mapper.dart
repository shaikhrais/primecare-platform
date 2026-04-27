// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/eta_tracker_widget_view_model.dart';
import '../dtos/eta_tracker_widget_dto.dart';

class EtaTrackerWidgetMapper {
  static EtaTrackerWidgetViewModel fromDto(EtaTrackerWidgetDto dto) {
    return EtaTrackerWidgetViewModel(
      title: dto.raw['title']?.toString() ?? 'etaTrackerWidget',
      metadata: dto.raw,
    );
  }
}
