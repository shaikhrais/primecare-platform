// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/greeting_header_widget_view_model.dart';
import '../dtos/greeting_header_widget_dto.dart';

class GreetingHeaderWidgetMapper {
  static GreetingHeaderWidgetViewModel fromDto(GreetingHeaderWidgetDto dto) {
    return GreetingHeaderWidgetViewModel(
      title: dto.raw['title']?.toString() ?? 'greetingHeaderWidget',
      metadata: dto.raw,
    );
  }
}
