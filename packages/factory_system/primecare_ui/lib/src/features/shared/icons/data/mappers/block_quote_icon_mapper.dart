// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/block_quote_icon_view_model.dart';
import '../dtos/block_quote_icon_dto.dart';

class BlockQuoteIconMapper {
  static BlockQuoteIconViewModel fromDto(BlockQuoteIconDto dto) {
    return BlockQuoteIconViewModel(
      title: dto.raw['title']?.toString() ?? 'blockQuoteIcon',
      metadata: dto.raw,
    );
  }
}
