// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_dialog_context_provider_view_model.dart';
import '../dtos/02_M_fuse_dialog_context_provider_dto.dart';

class FuseDialogContextProviderMapper {
  static FuseDialogContextProviderViewModel fromDto(FuseDialogContextProviderDto dto) {
    return FuseDialogContextProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseDialogContextProvider',
      metadata: dto.raw,
    );
  }
}

