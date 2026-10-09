import 'package:primecare_models/primecare_models.dart';

class RevenueModel extends BaseScreenState<RevenueModel> {
  const RevenueModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RevenueModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RevenueModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
