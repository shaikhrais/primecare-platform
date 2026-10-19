import 'package:primecare_models/primecare_models.dart';

class LeadConversionFunnelModel extends BaseScreenState<LeadConversionFunnelModel> {
  const LeadConversionFunnelModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LeadConversionFunnelModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LeadConversionFunnelModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
