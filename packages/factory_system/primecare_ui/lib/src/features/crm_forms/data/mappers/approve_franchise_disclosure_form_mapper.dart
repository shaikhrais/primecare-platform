// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/approve_franchise_disclosure_form_view_model.dart';
import '../dtos/approve_franchise_disclosure_form_dto.dart';

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
