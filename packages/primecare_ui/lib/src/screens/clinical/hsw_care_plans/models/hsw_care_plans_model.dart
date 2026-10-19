import 'package:primecare_models/primecare_models.dart';

class HswCarePlansModel extends BaseScreenState<HswCarePlansModel> {
  const HswCarePlansModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HswCarePlansModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HswCarePlansModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
