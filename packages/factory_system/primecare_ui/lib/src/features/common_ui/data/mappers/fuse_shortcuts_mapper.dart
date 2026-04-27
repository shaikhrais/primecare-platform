// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_shortcuts_view_model.dart';
import '../dtos/fuse_shortcuts_dto.dart';

class FuseShortcutsMapper {
  static FuseShortcutsViewModel fromDto(FuseShortcutsDto dto) {
    return FuseShortcutsViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseShortcuts',
      metadata: dto.raw,
    );
  }
}
