import 'package:primecare_models/primecare_models.dart';

class FollowupModel extends BaseScreenState<FollowupModel> {
  const FollowupModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FollowupModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FollowupModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
