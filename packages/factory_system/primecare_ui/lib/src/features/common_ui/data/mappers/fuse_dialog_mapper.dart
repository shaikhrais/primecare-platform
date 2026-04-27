// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_dialog_view_model.dart';
import '../dtos/fuse_dialog_dto.dart';

class FuseDialogMapper {
  static FuseDialogViewModel fromDto(FuseDialogDto dto) {
    return FuseDialogViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseDialog',
      metadata: dto.raw,
    );
  }
}
