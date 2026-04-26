// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_primecare_responsive_shell_view_model.dart';
import '../dtos/02_M_primecare_responsive_shell_dto.dart';

class PrimecareResponsiveShellMapper {
  static PrimecareResponsiveShellViewModel fromDto(
    PrimecareResponsiveShellDto dto,
  ) {
    return PrimecareResponsiveShellViewModel(
      title: dto.raw['title']?.toString() ?? 'primecareResponsiveShell',
      metadata: dto.raw,
    );
  }
}
