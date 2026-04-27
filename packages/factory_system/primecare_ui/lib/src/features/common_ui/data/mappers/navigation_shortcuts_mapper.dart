// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/navigation_shortcuts_view_model.dart';
import '../dtos/navigation_shortcuts_dto.dart';

class NavigationShortcutsMapper {
  static NavigationShortcutsViewModel fromDto(NavigationShortcutsDto dto) {
    return NavigationShortcutsViewModel(
      title: dto.raw['title']?.toString() ?? 'navigationShortcuts',
      metadata: dto.raw,
    );
  }
}
