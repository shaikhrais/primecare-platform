import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:primecare_core/primecare_core.dart';
import 'app_catalogs.dart';
import '../layout/base_primecare_layout.dart';

class AppLanguageController extends BaseLanguageWorkflow with ChangeNotifier {
  @override
  void changed() => notifyListeners();
}
final applicationLanguage = AppLanguageController();

class AppStrings extends BaseTextCatalog {
  const AppStrings(String languageCode) : super(languageCode, appCatalogs);
  static AppStrings of(BuildContext context) => Localizations.of<AppStrings>(context,AppStrings) ?? const AppStrings('en');
  String role(String code) => appCatalogs['en']!.containsKey('role.$code') ? text('role.$code') : code;
  String failureKey(AuthFailure error) => error.code != null && appCatalogs['en']!.containsKey(error.code) ? error.code! : switch (error.status) {
    401 => 'error.signInRequired', 403 => 'error.forbidden', 404 => 'error.notFound', 409 => 'error.duplicateEmail', 429 => 'error.rateLimit', 400 || 413 => 'error.invalidRequest', _ => 'error.authUnavailable',
  };
  static const locales = [Locale('en'),Locale('es'),Locale('fr')];
  static const delegates = <LocalizationsDelegate<dynamic>>[AppStringsDelegate(),GlobalMaterialLocalizations.delegate,GlobalWidgetsLocalizations.delegate,GlobalCupertinoLocalizations.delegate];
}
class AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const AppStringsDelegate();
  @override
  bool isSupported(Locale locale) => appCatalogs.containsKey(locale.languageCode);
  @override
  Future<AppStrings> load(Locale locale) => SynchronousFuture(AppStrings(locale.languageCode));
  @override
  bool shouldReload(AppStringsDelegate old) => false;
}
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min,children: [
    if (PrimecareLayoutData.of(context).size != PrimecareWindowSize.mobile && !PrimecareLayoutData.hasLargeText(context))
      Text(switch(applicationLanguage.language){SupportedLanguage.en=>'English',SupportedLanguage.es=>'Español',SupportedLanguage.fr=>'Français'}),
    PopupMenuButton<SupportedLanguage>(tooltip: AppStrings.of(context).text('language'),icon:const Icon(Icons.language),onSelected: applicationLanguage.selectLanguage,
      itemBuilder: (_) => [const PopupMenuItem(value:SupportedLanguage.en,child:Text('English')),const PopupMenuItem(value:SupportedLanguage.es,child:Text('Español')),const PopupMenuItem(value:SupportedLanguage.fr,child:Text('Français'))]),
  ]);
}
