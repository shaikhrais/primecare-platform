import 'package:primecare_models/primecare_models.dart';

class RnCarePlansModel extends BaseScreenState<RnCarePlansModel> {
  const RnCarePlansModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnCarePlansModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnCarePlansModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
