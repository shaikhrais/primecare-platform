// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_drag_assign_widget_view_model.dart';
import '../dtos/02_M_drag_assign_widget_dto.dart';

class DragAssignWidgetMapper {
  static DragAssignWidgetViewModel fromDto(DragAssignWidgetDto dto) {
    return DragAssignWidgetViewModel(
      title: dto.raw['title']?.toString() ?? 'dragAssignWidget',
      metadata: dto.raw,
    );
  }
}

