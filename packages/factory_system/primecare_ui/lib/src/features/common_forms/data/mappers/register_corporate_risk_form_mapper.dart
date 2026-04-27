// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/register_corporate_risk_form_view_model.dart';
import '../dtos/register_corporate_risk_form_dto.dart';

class RegisterCorporateRiskFormMapper {
  static RegisterCorporateRiskFormViewModel fromDto(
    RegisterCorporateRiskFormDto dto,
  ) {
    return RegisterCorporateRiskFormViewModel(
      title: dto.raw['title']?.toString() ?? 'registerCorporateRiskForm',
      metadata: dto.raw,
    );
  }
}
