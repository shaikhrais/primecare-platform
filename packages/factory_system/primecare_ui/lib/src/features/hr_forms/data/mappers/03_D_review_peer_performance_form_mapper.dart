// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_review_peer_performance_form_view_model.dart';
import '../dtos/02_M_review_peer_performance_form_dto.dart';

class ReviewPeerPerformanceFormMapper {
  static ReviewPeerPerformanceFormViewModel toViewModel(
    ReviewPeerPerformanceFormDto dto,
  ) {
    return ReviewPeerPerformanceFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static ReviewPeerPerformanceFormDto toDto(
    ReviewPeerPerformanceFormViewModel viewModel,
  ) {
    return ReviewPeerPerformanceFormDto(rawData: viewModel.data);
  }
}
