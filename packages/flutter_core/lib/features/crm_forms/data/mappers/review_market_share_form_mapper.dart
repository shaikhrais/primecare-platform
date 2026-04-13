import '../../domain/models/review_market_share_form_view_model.dart';
import '../dtos/review_market_share_form_dto.dart';

class ReviewMarketShareFormMapper {
  static ReviewMarketShareFormViewModel toViewModel(ReviewMarketShareFormDto dto) {
    return ReviewMarketShareFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static ReviewMarketShareFormDto toDto(ReviewMarketShareFormViewModel viewModel) {
    return ReviewMarketShareFormDto(
      rawData: viewModel.data,
    );
  }
}
