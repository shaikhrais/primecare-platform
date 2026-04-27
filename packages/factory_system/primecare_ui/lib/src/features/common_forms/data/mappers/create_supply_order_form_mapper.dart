// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/create_supply_order_form_view_model.dart';
import '../dtos/create_supply_order_form_dto.dart';

class CreateSupplyOrderFormMapper {
  static CreateSupplyOrderFormViewModel fromDto(CreateSupplyOrderFormDto dto) {
    return CreateSupplyOrderFormViewModel(
      title: dto.raw['title']?.toString() ?? 'createSupplyOrderForm',
      metadata: dto.raw,
    );
  }
}
