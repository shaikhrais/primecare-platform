import 'package:flutter_riverpod/legacy.dart';
import '../models/customer_support_issue_categories_model.dart';

class CustomerSupportIssueCategoriesNotifier extends StateNotifier<CustomerSupportIssueCategoriesModel> {
  CustomerSupportIssueCategoriesNotifier() : super(const CustomerSupportIssueCategoriesModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final customer_support_issue_categoriesProvider = StateNotifierProvider<CustomerSupportIssueCategoriesNotifier, CustomerSupportIssueCategoriesModel>((ref) {
  return CustomerSupportIssueCategoriesNotifier()..loadData();
});
