// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/slide_to_clock_in_widget_view_model.dart';
import '../dtos/slide_to_clock_in_widget_dto.dart';

class SlideToClockInWidgetMapper {
  static SlideToClockInWidgetViewModel fromDto(SlideToClockInWidgetDto dto) {
    return SlideToClockInWidgetViewModel(
      title: dto.raw['title']?.toString() ?? 'slideToClockInWidget',
      metadata: dto.raw,
    );
  }
}
