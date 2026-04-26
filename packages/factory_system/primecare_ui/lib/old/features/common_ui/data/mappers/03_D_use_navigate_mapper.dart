// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_use_navigate_view_model.dart';
import '../dtos/02_M_use_navigate_dto.dart';

class UseNavigateMapper {
  static UseNavigateViewModel fromDto(UseNavigateDto dto) {
    return UseNavigateViewModel(
      title: dto.raw['title']?.toString() ?? 'useNavigate',
      metadata: dto.raw,
    );
  }
}
