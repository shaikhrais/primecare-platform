import 'package:primecare_models/primecare_models.dart';

class RmtCommandCenterModel extends BaseScreenState<RmtCommandCenterModel> {
  const RmtCommandCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RmtCommandCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RmtCommandCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
