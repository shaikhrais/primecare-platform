// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/image_plus_icon_view_model.dart';
import '../dtos/image_plus_icon_dto.dart';

class ImagePlusIconMapper {
  static ImagePlusIconViewModel fromDto(ImagePlusIconDto dto) {
    return ImagePlusIconViewModel(
      title: dto.raw['title']?.toString() ?? 'imagePlusIcon',
      metadata: dto.raw,
    );
  }
}
