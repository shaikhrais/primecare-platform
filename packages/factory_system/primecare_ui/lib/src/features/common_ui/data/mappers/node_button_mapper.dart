// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/node_button_view_model.dart';
import '../dtos/node_button_dto.dart';

class NodeButtonMapper {
  static NodeButtonViewModel fromDto(NodeButtonDto dto) {
    return NodeButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'nodeButton',
      metadata: dto.raw,
    );
  }
}
