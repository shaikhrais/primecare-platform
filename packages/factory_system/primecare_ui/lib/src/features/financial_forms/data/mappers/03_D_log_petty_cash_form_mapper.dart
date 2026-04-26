// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_log_petty_cash_form_view_model.dart';
import '../dtos/02_M_log_petty_cash_form_dto.dart';

class LogPettyCashFormMapper {
  static LogPettyCashFormViewModel fromDto(LogPettyCashFormDto dto) {
    return LogPettyCashFormViewModel(
      title: dto.raw['title']?.toString() ?? 'logPettyCashForm',
      metadata: dto.raw,
    );
  }
}
