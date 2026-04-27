// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/example_view_view_model.dart';
import '../dtos/example_view_dto.dart';

class ExampleViewMapper {
  static ExampleViewViewModel fromDto(ExampleViewDto dto) {
    return ExampleViewViewModel(
      title: dto.raw['title']?.toString() ?? 'exampleView',
      metadata: dto.raw,
    );
  }
}
