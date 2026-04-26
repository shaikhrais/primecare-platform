// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_create_custom_invoice_form_view_model.dart';
import '../dtos/02_M_create_custom_invoice_form_dto.dart';

class CreateCustomInvoiceFormMapper {
  static CreateCustomInvoiceFormViewModel fromDto(
    CreateCustomInvoiceFormDto dto,
  ) {
    return CreateCustomInvoiceFormViewModel(
      title: dto.raw['title']?.toString() ?? 'createCustomInvoiceForm',
      metadata: dto.raw,
    );
  }
}
