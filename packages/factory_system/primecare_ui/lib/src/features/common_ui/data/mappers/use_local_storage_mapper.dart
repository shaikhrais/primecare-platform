// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/use_local_storage_view_model.dart';
import '../dtos/use_local_storage_dto.dart';

class UseLocalStorageMapper {
  static UseLocalStorageViewModel fromDto(UseLocalStorageDto dto) {
    return UseLocalStorageViewModel(
      title: dto.raw['title']?.toString() ?? 'useLocalStorage',
      metadata: dto.raw,
    );
  }
}
