import 'package:flutter_core/flutter_core.dart';

/// Preserve the validated app destination and requested accessibility semantics
/// across the existing public auth pages.
String authPageLocation(Uri source, String path) {
  final target = validateAppReturnUrl(source.queryParameters['returnUrl']);
  final semantics = source.queryParameters['enable-semantics'] == 'true' ||
      (target != null &&
          Uri.parse(target).queryParameters['enable-semantics'] == 'true');
  return Uri(path: path, queryParameters: {
    if (target != null) 'returnUrl': target,
    if (semantics) 'enable-semantics': 'true',
  }).toString();
}
