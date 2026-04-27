// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/mood_slider_widget_view_model.dart';
import '../dtos/mood_slider_widget_dto.dart';

class MoodSliderWidgetMapper {
  static MoodSliderWidgetViewModel fromDto(MoodSliderWidgetDto dto) {
    return MoodSliderWidgetViewModel(
      title: dto.raw['title']?.toString() ?? 'moodSliderWidget',
      metadata: dto.raw,
    );
  }
}
