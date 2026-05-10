import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governance/governance/controllers/governance_dashboard_controller.dart';
import 'package:primecare_governance/governance/models/governance_severity.dart';
import 'package:primecare_governance/governance/models/governance_category.dart';

void main() {
  group('GovernanceDashboardController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is correct', () {
      final state = container.read(governanceDashboardControllerProvider);

      expect(state.selectedSeverity, isNull);
      expect(state.selectedCategory, isNull);
      expect(state.searchQuery, isEmpty);
    });

    test('setSeverity updates state', () {
      final controller = container.read(
        governanceDashboardControllerProvider.notifier,
      );

      controller.setSeverity(GovernanceSeverity.critical);

      final state = container.read(governanceDashboardControllerProvider);
      expect(state.selectedSeverity, equals(GovernanceSeverity.critical));
    });

    test('setCategory updates state', () {
      final controller = container.read(
        governanceDashboardControllerProvider.notifier,
      );

      controller.setCategory(GovernanceCategory.routing);

      final state = container.read(governanceDashboardControllerProvider);
      expect(state.selectedCategory, equals(GovernanceCategory.routing));
    });

    test('setSearchQuery updates state', () {
      final controller = container.read(
        governanceDashboardControllerProvider.notifier,
      );

      controller.setSearchQuery('test query');

      final state = container.read(governanceDashboardControllerProvider);
      expect(state.searchQuery, equals('test query'));
    });

    test('clearFilters resets severity and category', () {
      final controller = container.read(
        governanceDashboardControllerProvider.notifier,
      );

      controller.setSeverity(GovernanceSeverity.critical);
      controller.setCategory(GovernanceCategory.routing);
      controller.setSearchQuery('test query');

      controller.clearFilters();

      final state = container.read(governanceDashboardControllerProvider);
      expect(state.selectedSeverity, isNull);
      expect(state.selectedCategory, isNull);
      expect(state.searchQuery, isEmpty);
    });
  });
}
