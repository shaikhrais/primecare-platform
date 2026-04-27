// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/submit_marketing_budget_form_view_model.dart';
import '../dtos/submit_marketing_budget_form_dto.dart';

class SubmitMarketingBudgetFormMapper {
  static SubmitMarketingBudgetFormViewModel fromDto(
    SubmitMarketingBudgetFormDto dto,
  ) {
    return SubmitMarketingBudgetFormViewModel(
      budgetId: dto.id ?? '',
      campaignName: dto.campaignName ?? '',
      totalBudget: dto.totalBudget?.toDouble() ?? 0.0,
      startDate: dto.startDate != null
          ? DateTime.tryParse(dto.startDate!)
          : null,
      endDate: dto.endDate != null ? DateTime.tryParse(dto.endDate!) : null,
      platform: dto.platform ?? '',
      details: dto.details ?? '',
    );
  }

  static SubmitMarketingBudgetFormDto toDto(
    SubmitMarketingBudgetFormViewModel model,
  ) {
    return SubmitMarketingBudgetFormDto(
      id: model.budgetId.isEmpty ? null : model.budgetId,
      campaignName: model.campaignName,
      totalBudget: model.totalBudget,
      startDate: model.startDate?.toIso8601String(),
      endDate: model.endDate?.toIso8601String(),
      platform: model.platform,
      details: model.details,
    );
  }
}
