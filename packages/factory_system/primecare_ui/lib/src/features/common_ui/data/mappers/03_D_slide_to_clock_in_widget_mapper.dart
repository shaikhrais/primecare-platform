// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_slide_to_clock_in_widget_view_model.dart';
import '../dtos/02_M_slide_to_clock_in_widget_dto.dart';

class SlideToClockInWidgetMapper {
  static SlideToClockInWidgetViewModel fromDto(SlideToClockInWidgetDto dto) {
    return SlideToClockInWidgetViewModel(
      title: dto.raw['title']?.toString() ?? 'slideToClockInWidget',
      metadata: dto.raw,
    );
  }
}

