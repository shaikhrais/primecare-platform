// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/error_boundary_view_model.dart';
import '../dtos/error_boundary_dto.dart';

class ErrorBoundaryMapper {
  static ErrorBoundaryViewModel fromDto(ErrorBoundaryDto dto) {
    return ErrorBoundaryViewModel(
      title: dto.raw['title']?.toString() ?? 'errorBoundary',
      metadata: dto.raw,
    );
  }
}
