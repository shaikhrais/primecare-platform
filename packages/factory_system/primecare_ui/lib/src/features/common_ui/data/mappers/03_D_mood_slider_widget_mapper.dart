// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_mood_slider_widget_view_model.dart';
import '../dtos/02_M_mood_slider_widget_dto.dart';

class MoodSliderWidgetMapper {
  static MoodSliderWidgetViewModel fromDto(MoodSliderWidgetDto dto) {
    return MoodSliderWidgetViewModel(
      title: dto.raw['title']?.toString() ?? 'moodSliderWidget',
      metadata: dto.raw,
    );
  }
}

