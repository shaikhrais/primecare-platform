import 'package:primecare_models/primecare_models.dart';

class PswTaskListModel extends BaseScreenState<PswTaskListModel> {
  const PswTaskListModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswTaskListModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswTaskListModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
