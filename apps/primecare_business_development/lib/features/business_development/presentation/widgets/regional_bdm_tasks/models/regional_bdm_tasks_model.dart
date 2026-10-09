import 'package:primecare_models/primecare_models.dart';

class RegionalBdmTasksModel extends BaseScreenState<RegionalBdmTasksModel> {
  const RegionalBdmTasksModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmTasksModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmTasksModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
