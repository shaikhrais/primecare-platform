// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_code_block_icon_view_model.dart';
import '../dtos/02_M_code_block_icon_dto.dart';

class CodeBlockIconMapper {
  static CodeBlockIconViewModel fromDto(CodeBlockIconDto dto) {
    return CodeBlockIconViewModel(
      title: dto.raw['title']?.toString() ?? 'codeBlockIcon',
      metadata: dto.raw,
    );
  }
}

