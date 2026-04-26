// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_provider_layout_view_model.dart';
import '../dtos/02_M_provider_layout_dto.dart';

class ProviderLayoutMapper {
  static ProviderLayoutViewModel fromDto(ProviderLayoutDto dto) {
    return ProviderLayoutViewModel(
      title: dto.raw['title']?.toString() ?? 'providerLayout',
      metadata: dto.raw,
    );
  }
}
