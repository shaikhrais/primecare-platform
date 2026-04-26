// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_data_table_view_model.dart';
import '../dtos/02_M_data_table_dto.dart';

class DataTableMapper {
  static DataTableViewModel fromDto(DataTableDto dto) {
    return DataTableViewModel(
      title: dto.raw['title']?.toString() ?? 'dataTable',
      metadata: dto.raw,
    );
  }
}
