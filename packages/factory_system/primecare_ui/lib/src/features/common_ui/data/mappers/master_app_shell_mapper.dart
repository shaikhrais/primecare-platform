// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/master_app_shell_view_model.dart';
import '../dtos/master_app_shell_dto.dart';

class MasterAppShellMapper {
  static MasterAppShellViewModel fromDto(MasterAppShellDto dto) {
    return MasterAppShellViewModel(
      title: dto.raw['title']?.toString() ?? 'masterAppShell',
      metadata: dto.raw,
    );
  }
}
