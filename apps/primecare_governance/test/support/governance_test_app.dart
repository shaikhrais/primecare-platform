import 'dart:convert';
import 'dart:io';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'repository_root.dart';

class GovernanceTestTranslations extends AssetLoader {
  const GovernanceTestTranslations();
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async =>
      jsonDecode(File('$path/${locale.languageCode}.json').readAsStringSync())
          as Map<String, dynamic>;
}

Future<void> initializeGovernanceTestApp() async {
  SharedPreferences.setMockInitialValues({});
  await EasyLocalization.ensureInitialized();
}

Widget governanceTestApp(Widget screen) => EasyLocalization(
  supportedLocales: const [Locale('en')],
  startLocale: const Locale('en'),
  path: '${repositoryRoot().path}/apps/primecare_governance/assets/translations',
  assetLoader: const GovernanceTestTranslations(),
  child: Builder(builder: (context) => PrimeTheme(
    data: const PrimeThemeData(),
    child: AppShellBoundary(child: MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: screen,
    )),
  )),
);
