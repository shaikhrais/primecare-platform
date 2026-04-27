// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/configurator_view_model.dart';
import '../dtos/configurator_dto.dart';

class ConfiguratorMapper {
  static ConfiguratorViewModel fromDto(ConfiguratorDto dto) {
    return ConfiguratorViewModel(
      title: dto.raw['title']?.toString() ?? 'configurator',
      metadata: dto.raw,
    );
  }
}
