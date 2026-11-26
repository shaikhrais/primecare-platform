// Legacy composition supplies the same application language provider.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_app_runtime/primecare_app_runtime.dart' as runtime;
import '../localization/language_provider.dart';

String _watchLanguage(WidgetRef ref) => ref.watch(languageProvider);
String _readLanguage(WidgetRef ref) => ref.read(languageProvider);

class PrimeCareAppRunner {
  static void run({required Widget appWidget, List<dynamic> overrides = const []}) =>
      runtime.PrimeCareAppRunner.run(appWidget: appWidget, overrides: overrides,
        localeWrapper: (child) => LocaleRebuildWrapper(child: child));
}

class LocaleRebuildWrapper extends runtime.LocaleRebuildWrapper {
  const LocaleRebuildWrapper({Key? key, required Widget child})
    : super(key: key, child: child, watchLanguage: _watchLanguage, readLanguage: _readLanguage);
}
