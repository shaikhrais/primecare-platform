// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_purchase_button_view_model.dart';
import '../dtos/02_M_purchase_button_dto.dart';

class PurchaseButtonMapper {
  static PurchaseButtonViewModel fromDto(PurchaseButtonDto dto) {
    return PurchaseButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'purchaseButton',
      metadata: dto.raw,
    );
  }
}

