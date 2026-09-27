// Governance - Category: service | Purpose: The [PlatformParityEngine] is the central intelligence unit that validates the interaction between Screen classes and...
import '../models/api_metadata.dart';
import '../models/screen_metadata.dart';

/// The [PlatformParityEngine] is the central intelligence unit that 
/// validates the interaction between Screen classes and API classes.
class PlatformParityEngine {
  /// Checks if a screen's API requirements are fully satisfied by the registered APIs.
  static ParityResult checkScreenParity(
    ScreenMetadata screen,
    Map<String, ApiMetadata> registeredApis,
  ) {
    final missingApis = <String>[];
    final mismatchingApis = <String>[];

    for (final apiId in screen.requiredApis) {
      final api = registeredApis[apiId];
      
      if (api == null) {
        missingApis.add(apiId);
      } else if (api.designSize != screen.designSize) {
        // 4K Standard Parity Check
        mismatchingApis.add(apiId);
      }
    }

    return ParityResult(
      screenId: screen.id,
      isCompliant: missingApis.isEmpty && mismatchingApis.isEmpty,
      missingApis: missingApis,
      mismatchingApis: mismatchingApis,
    );
  }
}

/// Represents the result of a parity check between a UI Screen and its Backend APIs.
class ParityResult {
  final String screenId;
  final bool isCompliant;
  final List<String> missingApis;
  final List<String> mismatchingApis;

  ParityResult({
    required this.screenId,
    required this.isCompliant,
    this.missingApis = const [],
    this.mismatchingApis = const [],
  });
}
