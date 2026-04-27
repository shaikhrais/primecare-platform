// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/log_inventory_spoilage_form_view_model.dart';
import '../dtos/log_inventory_spoilage_form_dto.dart';

class LogInventorySpoilageFormMapper {
  static LogInventorySpoilageFormViewModel fromDto(
    LogInventorySpoilageFormDto dto,
  ) {
    return LogInventorySpoilageFormViewModel(
      title: dto.raw['title']?.toString() ?? 'logInventorySpoilageForm',
      metadata: dto.raw,
    );
  }
}
