// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/create_ad_placement_form_view_model.dart';
import '../dtos/create_ad_placement_form_dto.dart';

class CreateAdPlacementFormMapper {
  static CreateAdPlacementFormViewModel toViewModel(
    CreateAdPlacementFormDto dto,
  ) {
    return CreateAdPlacementFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static CreateAdPlacementFormDto toDto(
    CreateAdPlacementFormViewModel viewModel,
  ) {
    return CreateAdPlacementFormDto(rawData: viewModel.data);
  }
}
