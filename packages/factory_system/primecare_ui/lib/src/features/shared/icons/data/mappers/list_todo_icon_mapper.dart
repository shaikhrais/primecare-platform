// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/list_todo_icon_view_model.dart';
import '../dtos/list_todo_icon_dto.dart';

class ListTodoIconMapper {
  static ListTodoIconViewModel fromDto(ListTodoIconDto dto) {
    return ListTodoIconViewModel(
      title: dto.raw['title']?.toString() ?? 'listTodoIcon',
      metadata: dto.raw,
    );
  }
}
