import 'package:primecare_models/primecare_models.dart';

class CustomerSupportIssueCategoriesModel extends BaseScreenState<CustomerSupportIssueCategoriesModel> {
  const CustomerSupportIssueCategoriesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CustomerSupportIssueCategoriesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CustomerSupportIssueCategoriesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
