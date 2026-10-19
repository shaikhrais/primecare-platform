import 'package:primecare_models/primecare_models.dart';

class RegionalBdmReportsModel extends BaseScreenState<RegionalBdmReportsModel> {
  const RegionalBdmReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
