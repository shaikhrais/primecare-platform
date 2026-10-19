import 'package:primecare_models/primecare_models.dart';

class MarketingROIReportModel extends BaseScreenState<MarketingROIReportModel> {
  const MarketingROIReportModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MarketingROIReportModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MarketingROIReportModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
