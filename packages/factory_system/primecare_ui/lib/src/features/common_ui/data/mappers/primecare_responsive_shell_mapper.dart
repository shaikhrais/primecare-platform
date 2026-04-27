// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/primecare_responsive_shell_view_model.dart';
import '../dtos/primecare_responsive_shell_dto.dart';

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
