import '../../domain/models/add_franchise_lead_form_view_model.dart';
import '../dtos/add_franchise_lead_form_dto.dart';

class AddFranchiseLeadFormMapper {
  static AddFranchiseLeadFormViewModel fromDto(AddFranchiseLeadFormDto dto) {
    return AddFranchiseLeadFormViewModel(
      leadId: dto.id ?? '',
      name: dto.name ?? '',
      email: dto.email ?? '',
      phone: dto.phone ?? '',
      territoryOfInterest: dto.territoryOfInterest ?? '',
      details: dto.details ?? '',
      status: dto.status ?? 'New',
    );
  }

  static AddFranchiseLeadFormDto toDto(AddFranchiseLeadFormViewModel model) {
    return AddFranchiseLeadFormDto(
      id: model.leadId.isEmpty ? null : model.leadId,
      name: model.name,
      email: model.email,
      phone: model.phone,
      territoryOfInterest: model.territoryOfInterest,
      details: model.details,
      status: model.status,
    );
  }
}
