import 'package:primecare_models/primecare_models.dart';

class HomeCarePlanModel extends BaseScreenState<HomeCarePlanModel> {
  const HomeCarePlanModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HomeCarePlanModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HomeCarePlanModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
