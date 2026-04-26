// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_approve_franchise_disclosure_form_view_model.dart';
import '../dtos/02_M_approve_franchise_disclosure_form_dto.dart';

class ApproveFranchiseDisclosureFormMapper {
  static ApproveFranchiseDisclosureFormViewModel toViewModel(
    ApproveFranchiseDisclosureFormDto dto,
  ) {
    return ApproveFranchiseDisclosureFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static ApproveFranchiseDisclosureFormDto toDto(
    ApproveFranchiseDisclosureFormViewModel viewModel,
  ) {
    return ApproveFranchiseDisclosureFormDto(rawData: viewModel.data);
  }
}
