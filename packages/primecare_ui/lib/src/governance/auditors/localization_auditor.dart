import 'package:flutter_core/flutter_core.dart';
import '../automated_audit_engine.dart';

class LocalizationAuditor {
  static List<AuditResultItem> audit(
    List<ScreenMetadata> screens, {
    Map<String, dynamic>? localizationData,
  }) {
    final results = <AuditResultItem>[];

    int missingL10n = 0;
    int missingKeys = 0;
    int missingKeysInFile = 0;

    for (final screen in screens) {
      if (!screen.hasAllTranslations) {
        missingL10n++;
      }
      if (screen.translationKeys.isEmpty && !screen.isVirtual) {
        missingKeys++;
      }

      if (localizationData != null && screen.translationKeys.isNotEmpty) {
        for (final key in screen.translationKeys) {
          if (!_keyExists(localizationData, key)) {
            missingKeysInFile++;
            break;
          }
        }
      }
    }

    results.add(
      AuditResultItem(
        check: 'Localization Parity Audit',
        result: missingL10n == 0 ? 'PASSED' : 'FAILED',
        isPass: missingL10n == 0,
        meaning: missingL10n == 0
            ? 'All screens have reached 100% translation parity.'
            : '$missingL10n screens have missing translations in supported locales.',
        fix:
            'Run "primecare l10n sync" or manually update missing locale files.',
      ),
    );

    results.add(
      AuditResultItem(
        check: 'Translation Keys Definition',
        result: missingKeys == 0 ? 'PASSED' : 'WARNING',
        isPass: true,
        isWarning: missingKeys > 0,
        meaning: missingKeys == 0
            ? 'All screens have explicitly defined translation namespaces.'
            : '$missingKeys screens are missing translation key definitions in metadata.',
        fix:
            'Populate "translationKeys" attribute in ScreenMetadata for precise auditing.',
      ),
    );

    if (localizationData != null) {
      results.add(
        AuditResultItem(
          check: 'Registry-Source Sync (L10N)',
          result: missingKeysInFile == 0 ? 'PASSED' : 'FAILED',
          isPass: missingKeysInFile == 0,
          meaning: missingKeysInFile == 0
              ? 'All defined translation keys exist in the primary locale file.'
              : '$missingKeysInFile screens reference keys that are missing in en.json.',
          fix:
              'Add missing keys to "packages/flutter_core/lib/src/localization/en.json".',
        ),
      );
    }

    return results;
  }

  static bool _keyExists(Map<String, dynamic> data, String keyPath) {
    final parts = keyPath.split('.');
    dynamic current = data;

    for (final part in parts) {
      if (current is Map && current.containsKey(part)) {
        current = current[part];
      } else {
        return false;
      }
    }

    return true;
  }
}
