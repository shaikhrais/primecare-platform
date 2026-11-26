// Legacy composition only: the canonical language implementation is independent of Core.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_localization/src/localization/language_provider.dart';
import '../../auth_service.dart';
export 'package:primecare_localization/src/localization/language_provider.dart';

class LanguageNotifier extends LanguageNotifierBase {
  @override String? watchPreferredLanguage() => ref.watch(authProvider.select((s) => s.preferredLanguage));
  @override Future<void> persistPreferredLanguage(String langCode) => ref.read(authProvider.notifier).updatePreferredLanguage(langCode);
}
final languageProvider = NotifierProvider<LanguageNotifier, String>(LanguageNotifier.new);
