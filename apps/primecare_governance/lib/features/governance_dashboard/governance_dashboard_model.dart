import '../../governance/models/governance_severity.dart';
import '../../governance/models/governance_category.dart';

class GovernanceDashboardModel {
  final GovernanceSeverity? selectedSeverity;
  final GovernanceCategory? selectedCategory;
  final String searchQuery;

  const GovernanceDashboardModel({
    this.selectedSeverity,
    this.selectedCategory,
    this.searchQuery = '',
  });

  GovernanceDashboardModel copyWith({
    GovernanceSeverity? selectedSeverity,
    bool clearSeverity = false,
    GovernanceCategory? selectedCategory,
    bool clearCategory = false,
    String? searchQuery,
  }) {
    return GovernanceDashboardModel(
      selectedSeverity: clearSeverity
          ? null
          : (selectedSeverity ?? this.selectedSeverity),
      selectedCategory: clearCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
