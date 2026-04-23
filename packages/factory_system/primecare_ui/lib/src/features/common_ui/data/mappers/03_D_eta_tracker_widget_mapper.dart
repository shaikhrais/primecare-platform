// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_eta_tracker_widget_view_model.dart';
import '../dtos/02_M_eta_tracker_widget_dto.dart';

class EtaTrackerWidgetMapper {
  static EtaTrackerWidgetViewModel fromDto(EtaTrackerWidgetDto dto) {
    return EtaTrackerWidgetViewModel(
      title: dto.raw['title']?.toString() ?? 'etaTrackerWidget',
      metadata: dto.raw,
    );
  }
}

