import 'package:primecare_models/primecare_models.dart';

class AdminOutstandingBalancesModel extends BaseScreenState<AdminOutstandingBalancesModel> {
  const AdminOutstandingBalancesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AdminOutstandingBalancesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AdminOutstandingBalancesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
