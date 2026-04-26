// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_configurator_view_model.dart';
import '../dtos/02_M_configurator_dto.dart';

class ConfiguratorMapper {
  static ConfiguratorViewModel fromDto(ConfiguratorDto dto) {
    return ConfiguratorViewModel(
      title: dto.raw['title']?.toString() ?? 'configurator',
      metadata: dto.raw,
    );
  }
}
