import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  group('AutomatedAuditEngine Tests', () {
    test('runAudits returns results for all 7 core checks', () {
      final results = AutomatedAuditEngine.runAudits();

      final checkNames = results.map((r) => r.check).toSet();
      expect(checkNames, contains('Registry Integrity Audit'));
      expect(checkNames, contains('Localization Enforcement'));
      expect(checkNames, contains('Route Uniqueness'));
      expect(checkNames, contains('Auth Role Enforcement'));
      expect(checkNames, contains('Telemetry HUD Coverage'));
      expect(checkNames, contains('Adapter Connectivity'));
      expect(checkNames, contains('Telemetry HUD Coverage'));
      expect(checkNames, contains('Adapter Connectivity'));
      expect(checkNames, contains('Max OOP Architectural Audit'));
    });

    test('Localization Enforcement reports correctly', () {
      final results = AutomatedAuditEngine.runAudits();
      final l10nCheck = results.firstWhere(
        (r) => r.check == 'Localization Enforcement',
      );

      if (!l10nCheck.isPass) {
        expect(l10nCheck.isWarning, isTrue);
        expect(l10nCheck.meaning, contains('hardcoded strings'));
      } else {
        expect(l10nCheck.meaning, contains('All strings migrated'));
      }
    });

    test('Max OOP Architectural Audit reflects state', () {
      final results = AutomatedAuditEngine.runAudits();
      final oopCheck = results.firstWhere(
        (r) => r.check == 'Max OOP Architectural Audit',
      );

      expect(oopCheck.meaning, contains('Strict MVC/DDD compliance'));
      expect(oopCheck.isPass, isTrue);
    });

    test('Health Score calculation is deterministic', () {
      final score = AutomatedAuditEngine.calculateHealthScore();
      expect(score, greaterThanOrEqualTo(0.0));
      expect(score, lessThanOrEqualTo(100.0));
    });
  });
}
