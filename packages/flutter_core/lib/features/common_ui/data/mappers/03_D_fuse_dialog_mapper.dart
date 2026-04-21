// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_dialog_view_model.dart';
import '../dtos/02_M_fuse_dialog_dto.dart';

class FuseDialogMapper {
  static FuseDialogViewModel fromDto(FuseDialogDto dto) {
    return FuseDialogViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseDialog',
      metadata: dto.raw,
    );
  }
}

