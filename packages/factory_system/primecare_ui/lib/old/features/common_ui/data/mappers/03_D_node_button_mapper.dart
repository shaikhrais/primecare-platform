// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_node_button_view_model.dart';
import '../dtos/02_M_node_button_dto.dart';

class NodeButtonMapper {
  static NodeButtonViewModel fromDto(NodeButtonDto dto) {
    return NodeButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'nodeButton',
      metadata: dto.raw,
    );
  }
}
