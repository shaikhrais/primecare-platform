// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/use_fuse_dialog_context_view_model.dart';
import '../dtos/use_fuse_dialog_context_dto.dart';

class UseFuseDialogContextMapper {
  static UseFuseDialogContextViewModel fromDto(UseFuseDialogContextDto dto) {
    return UseFuseDialogContextViewModel(
      title: dto.raw['title']?.toString() ?? 'useFuseDialogContext',
      metadata: dto.raw,
    );
  }
}
