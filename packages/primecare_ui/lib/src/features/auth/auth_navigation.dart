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


/// Carry the explicitly requested accessibility DOM to an already validated
/// internal destination, preserving its query values and fragment.
String withAuthSemantics(Uri source, String destination) {
  final target = validateAppReturnUrl(source.queryParameters['returnUrl']);
  final enabled = source.queryParameters['enable-semantics'] == 'true' ||
      (target != null && Uri.parse(target).queryParameters['enable-semantics'] == 'true');
  if (!enabled) return destination;
  final uri = Uri.parse(destination);
  return uri.replace(queryParameters: {
    for (final entry in uri.queryParametersAll.entries)
      if (entry.key != 'enable-semantics') entry.key: entry.value,
    'enable-semantics': 'true',
  }).toString();
}
