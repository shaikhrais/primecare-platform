import 'package:primecare_models/primecare_models.dart';

class RmtBillingLinkModel extends BaseScreenState<RmtBillingLinkModel> {
  const RmtBillingLinkModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RmtBillingLinkModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RmtBillingLinkModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
