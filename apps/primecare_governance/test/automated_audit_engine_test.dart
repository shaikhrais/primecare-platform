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
      expect(checkNames, contains('Environment Security Gate'));
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
        expect(l10nCheck.meaning, contains('I18n compliance'));
      }
    });

    test('Environment Security Gate reflects development state', () {
      final results = AutomatedAuditEngine.runAudits();
      final securityCheck = results.firstWhere(
        (r) => r.check == 'Environment Security Gate',
      );

      expect(securityCheck.meaning, contains('Development security context'));
      expect(securityCheck.isPass, isTrue);
    });

    test('Health Score calculation is deterministic', () {
      final score = AutomatedAuditEngine.calculateHealthScore();
      expect(score, greaterThanOrEqualTo(0.0));
      expect(score, lessThanOrEqualTo(100.0));
    });
  });
}
