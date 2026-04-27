// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/log_petty_cash_form_view_model.dart';
import '../dtos/log_petty_cash_form_dto.dart';

class LogPettyCashFormMapper {
  static LogPettyCashFormViewModel fromDto(LogPettyCashFormDto dto) {
    return LogPettyCashFormViewModel(
      title: dto.raw['title']?.toString() ?? 'logPettyCashForm',
      metadata: dto.raw,
    );
  }
}
