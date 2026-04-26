// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_review_peer_performance_form_view_model.dart';
import '../dtos/02_M_review_peer_performance_form_dto.dart';

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
