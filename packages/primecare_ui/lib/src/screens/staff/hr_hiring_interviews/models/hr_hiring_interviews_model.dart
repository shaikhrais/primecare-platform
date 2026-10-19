import 'package:primecare_models/primecare_models.dart';

class HrHiringInterviewsModel extends BaseScreenState<HrHiringInterviewsModel> {
  const HrHiringInterviewsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrHiringInterviewsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrHiringInterviewsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
