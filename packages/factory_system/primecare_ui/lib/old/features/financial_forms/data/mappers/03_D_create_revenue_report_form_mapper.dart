// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_create_revenue_report_form_view_model.dart';
import '../dtos/02_M_create_revenue_report_form_dto.dart';

class CreateRevenueReportFormMapper {
  static CreateRevenueReportFormViewModel fromDto(
    CreateRevenueReportFormDto dto,
  ) {
    return CreateRevenueReportFormViewModel(
      title: dto.raw['title']?.toString() ?? 'createRevenueReportForm',
      metadata: dto.raw,
    );
  }
}
