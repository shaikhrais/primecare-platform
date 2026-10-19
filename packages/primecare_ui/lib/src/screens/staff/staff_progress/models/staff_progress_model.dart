import 'package:primecare_models/primecare_models.dart';

class StaffProgressModel extends BaseScreenState<StaffProgressModel> {
  const StaffProgressModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  StaffProgressModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => StaffProgressModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
