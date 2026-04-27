// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/code_block_icon_view_model.dart';
import '../dtos/code_block_icon_dto.dart';

class CodeBlockIconMapper {
  static CodeBlockIconViewModel fromDto(CodeBlockIconDto dto) {
    return CodeBlockIconViewModel(
      title: dto.raw['title']?.toString() ?? 'codeBlockIcon',
      metadata: dto.raw,
    );
  }
}
