import 'package:primecare_models/primecare_models.dart';

class HrHiringReportsModel extends BaseScreenState<HrHiringReportsModel> {
  const HrHiringReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrHiringReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrHiringReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
