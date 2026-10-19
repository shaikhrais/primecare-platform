import 'package:primecare_models/primecare_models.dart';

class PhysiotherapistReportsModel extends BaseScreenState<PhysiotherapistReportsModel> {
  const PhysiotherapistReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysiotherapistReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysiotherapistReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
