// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_audit_royalty_payment_form_view_model.dart';
import '../dtos/02_M_audit_royalty_payment_form_dto.dart';

class AuditRoyaltyPaymentFormMapper {
  static AuditRoyaltyPaymentFormViewModel fromDto(
    AuditRoyaltyPaymentFormDto dto,
  ) {
    return AuditRoyaltyPaymentFormViewModel(
      title: dto.raw['title']?.toString() ?? 'auditRoyaltyPaymentForm',
      metadata: dto.raw,
    );
  }
}
