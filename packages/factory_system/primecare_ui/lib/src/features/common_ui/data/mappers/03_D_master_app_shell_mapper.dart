// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_master_app_shell_view_model.dart';
import '../dtos/02_M_master_app_shell_dto.dart';

class MasterAppShellMapper {
  static MasterAppShellViewModel fromDto(MasterAppShellDto dto) {
    return MasterAppShellViewModel(
      title: dto.raw['title']?.toString() ?? 'masterAppShell',
      metadata: dto.raw,
    );
  }
}
