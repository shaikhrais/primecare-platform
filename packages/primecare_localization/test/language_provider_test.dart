import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_localization/primecare_localization.dart';
import 'package:primecare_preferences/providers/persistence_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FixtureLanguage extends LanguageNotifierBase {
  String? saved;
  @override String? watchPreferredLanguage() => 'fr';
  @override Future<void> persistPreferredLanguage(String langCode) async { saved = langCode; }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('host profile and guest preference retain their existing precedence', () async {
    SharedPreferences.setMockInitialValues({'auth_preferred_language': 'fr'});
    final prefs = await SharedPreferences.getInstance();
    final provider = NotifierProvider<FixtureLanguage, String>(FixtureLanguage.new);
    final container = ProviderContainer(overrides: [sharedPreferencesProvider.overrideWithValue(prefs)]);
    addTearDown(container.dispose);
    expect(container.read(provider), 'fr');
    await container.read(provider.notifier).setLanguage('es');
    expect(container.read(provider), 'es');
    expect(container.read(provider.notifier).saved, 'es');
    expect(prefs.getString('auth_preferred_language'), 'es');
  });
}
