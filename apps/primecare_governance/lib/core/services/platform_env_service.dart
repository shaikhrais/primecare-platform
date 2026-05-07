import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlatformEnvService {
  /// The root directory of the PrimeCare platform repository.
  /// This can be injected via --dart-define=PROJECT_ROOT=/path/to/repo
  static const String projectRoot = String.fromEnvironment(
    'PROJECT_ROOT',
    defaultValue: 'C:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform',
  );

  /// Constructs a VS Code deep-link URI for a given relative path within the repo.
  Uri getVSCodeUri(String relativePath) {
    // Ensure the relative path doesn't have a leading slash if projectRoot ends with one
    final sanitizedRelativePath =
        relativePath.startsWith('/') || relativePath.startsWith('\\')
        ? relativePath.substring(1)
        : relativePath;

    // Normalize path separators for the current OS
    final fullPath =
        '$projectRoot${Platform.pathSeparator}$sanitizedRelativePath';

    // VS Code URI scheme: vscode://file/{fullPath}
    // Note: On Windows, we might need a triple slash or drive letter handling
    return Uri.parse('vscode://file/$fullPath');
  }

  /// Whether the current platform supports deep-linking to local files
  bool get supportsDeepLinking =>
      Platform.isWindows || Platform.isMacOS || Platform.isLinux;
}

final platformEnvServiceProvider = Provider((ref) => PlatformEnvService());
