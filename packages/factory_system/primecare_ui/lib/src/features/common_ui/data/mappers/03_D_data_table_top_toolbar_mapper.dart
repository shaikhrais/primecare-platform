// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_data_table_top_toolbar_view_model.dart';
import '../dtos/02_M_data_table_top_toolbar_dto.dart';

class DataTableTopToolbarMapper {
  static DataTableTopToolbarViewModel fromDto(DataTableTopToolbarDto dto) {
    return DataTableTopToolbarViewModel(
      title: dto.raw['title']?.toString() ?? 'dataTableTopToolbar',
      metadata: dto.raw,
    );
  }
}
