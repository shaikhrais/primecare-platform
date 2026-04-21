// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_image_upload_node_view_model.dart';
import '../dtos/02_M_image_upload_node_dto.dart';

class ImageUploadNodeMapper {
  static ImageUploadNodeViewModel fromDto(ImageUploadNodeDto dto) {
    return ImageUploadNodeViewModel(
      title: dto.raw['title']?.toString() ?? 'imageUploadNode',
      metadata: dto.raw,
    );
  }
}

