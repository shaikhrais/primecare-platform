// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_image_upload_button_view_model.dart';
import '../dtos/02_M_image_upload_button_dto.dart';

class ImageUploadButtonMapper {
  static ImageUploadButtonViewModel fromDto(ImageUploadButtonDto dto) {
    return ImageUploadButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'imageUploadButton',
      metadata: dto.raw,
    );
  }
}

