import 'package:primecare_models/primecare_models.dart';

class RpnTasksModel extends BaseScreenState<RpnTasksModel> {
  const RpnTasksModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RpnTasksModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RpnTasksModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
