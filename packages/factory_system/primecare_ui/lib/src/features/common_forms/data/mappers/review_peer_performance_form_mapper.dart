// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/review_peer_performance_form_view_model.dart';
import '../dtos/review_peer_performance_form_dto.dart';

class ReviewPeerPerformanceFormMapper {
  static ReviewPeerPerformanceFormViewModel fromDto(
    ReviewPeerPerformanceFormDto dto,
  ) {
    return ReviewPeerPerformanceFormViewModel(
      title: dto.raw['title']?.toString() ?? 'reviewPeerPerformanceForm',
      metadata: dto.raw,
    );
  }
}
