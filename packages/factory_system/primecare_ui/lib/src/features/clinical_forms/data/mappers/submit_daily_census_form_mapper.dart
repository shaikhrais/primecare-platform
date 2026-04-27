// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/submit_daily_census_form_view_model.dart';
import '../dtos/submit_daily_census_form_dto.dart';

class SubmitDailyCensusFormMapper {
  static SubmitDailyCensusFormViewModel fromDto(SubmitDailyCensusFormDto dto) {
    return SubmitDailyCensusFormViewModel(
      title: dto.raw['title']?.toString() ?? 'submitDailyCensusForm',
      metadata: dto.raw,
    );
  }
}
