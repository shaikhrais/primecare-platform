// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_error_boundary_view_model.dart';
import '../dtos/02_M_error_boundary_dto.dart';

class ErrorBoundaryMapper {
  static ErrorBoundaryViewModel fromDto(ErrorBoundaryDto dto) {
    return ErrorBoundaryViewModel(
      title: dto.raw['title']?.toString() ?? 'errorBoundary',
      metadata: dto.raw,
    );
  }
}

