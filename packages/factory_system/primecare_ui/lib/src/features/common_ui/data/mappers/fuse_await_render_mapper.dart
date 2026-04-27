// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_await_render_view_model.dart';
import '../dtos/fuse_await_render_dto.dart';

class FuseAwaitRenderMapper {
  static FuseAwaitRenderViewModel fromDto(FuseAwaitRenderDto dto) {
    return FuseAwaitRenderViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseAwaitRender',
      metadata: dto.raw,
    );
  }
}
