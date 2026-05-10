import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/governance/controllers/governance_dashboard_controller.dart';
import 'package:flutter_core/flutter_core.dart';

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

      controller.setSeverity(AuditSeverity.critical);

      final state = container.read(governanceDashboardControllerProvider);
      expect(state.selectedSeverity, equals(AuditSeverity.critical));
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

      controller.setSeverity(AuditSeverity.critical);
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
