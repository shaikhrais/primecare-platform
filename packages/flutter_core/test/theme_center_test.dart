import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';import 'package:flutter_riverpod/flutter_riverpod.dart';import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';import 'package:flutter_core/providers/persistence_providers.dart';import 'package:flutter_core/theme/personal_theme.dart';import 'package:flutter_core/theme/theme_center_catalog_generated.dart';import 'package:flutter_core/theme/theme_library_provider.dart';import 'package:flutter_core/theme/theme_settings_provider.dart';
class TestThemeAuth extends AuthNotifier {AuthState initial;TestThemeAuth(this.initial);@override AuthState build()=>initial;void switchUser(AuthState value)=>state=value;}
void main(){
 test('portable theme validation covers all presets and rejects injection/unknown settings',(){
  for(final preset in themeCenterPresetNames){final theme=PersonalTheme(name:'My theme',preset:preset).validated();expect(PersonalTheme.importJson(theme.exportJson()).preset,preset);}
  final valid=PersonalTheme(name:'Own',preset:'default').toJson();
  for(final patch in [{'role':'ceo'},{'fontScale':2},{'radius':25},{'preset':'not-registered'},{'colors':{'primary':'url(x)'}},{'colors':{'permissions':'#ffffff'}},{'name':'\nBad'}])expect(()=>PersonalTheme.fromJson({...valid,...patch}),throwsFormatException);
  expect(()=>PersonalTheme.importJson(' '*17000),throwsFormatException);
 });
 test('personal library CRUD survives restart and isolates account/role preferences',()async{
  SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();
  AuthState actor(String id,String role)=>AuthState(isAuthenticated:true,userId:id,tenantId:'tenant-a',role:role);
  ProviderContainer container(String id,String role)=>ProviderContainer(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),authProvider.overrideWith(()=>TestThemeAuth(actor(id,role)))]);
  final a=container('actor-a','admin');addTearDown(a.dispose);final store=a.read(themeLibraryProvider.notifier);final theme=PersonalTheme(name:'My Navy',preset:'navyTealPalette',fontScale:1.25,colors:{'primary':'#ffffff'});
  final id=await store.save(theme);expect(a.read(themeLibraryProvider).single.theme.name,'My Navy');await store.rename(id,'Renamed');await store.duplicate(id,'Copy');expect(a.read(themeLibraryProvider).length,2);await expectLater(store.save(theme.named('Copy')),throwsStateError);
  await a.read(themeSettingsProvider.notifier).applyPersonalTheme(theme);await a.read(themeSettingsProvider.notifier).updateLayoutStyle(LayoutStyle.verticalRight);
  final restarted=container('actor-a','admin');addTearDown(restarted.dispose);expect(restarted.read(themeLibraryProvider).length,2);expect(restarted.read(themeSettingsProvider).theme.fontScale,1.25);expect(restarted.read(themeSettingsProvider).layoutStyle,LayoutStyle.verticalRight);
  final b=container('actor-b','admin');addTearDown(b.dispose);expect(b.read(themeLibraryProvider),isEmpty);expect(b.read(themeSettingsProvider).theme.colors,isEmpty);
  final role=container('actor-a','rmt');addTearDown(role.dispose);expect(role.read(themeLibraryProvider),isEmpty);
  final notifier=a.read(authProvider.notifier) as TestThemeAuth;notifier.switchUser(actor('actor-b','admin'));expect(a.read(themeLibraryProvider),isEmpty);expect(a.read(themeSettingsProvider).theme.colors,isEmpty);
  await restarted.read(themeLibraryProvider.notifier).remove(id);expect(restarted.read(themeLibraryProvider).length,1);
 });
 test('malformed stored preferences fall back without applying them',()async{
  final auth=AuthState(isAuthenticated:true,userId:'bad',tenantId:'tenant',role:'admin');final scope=themeAccountScope(auth);SharedPreferences.setMockInitialValues({'theme_center_settings_v1:$scope':jsonEncode({'version':2}),'theme_center_library_v1:$scope':'not json'});final prefs=await SharedPreferences.getInstance();final c=ProviderContainer(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),authProvider.overrideWith(()=>TestThemeAuth(auth))]);addTearDown(c.dispose);expect(c.read(themeSettingsProvider).theme.colors,isEmpty);expect(c.read(themeLibraryProvider),isEmpty);
 });
 test('theme limit leaves existing library intact',()async{
  SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();final c=ProviderContainer(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),authProvider.overrideWith(()=>TestThemeAuth(AuthState(isAuthenticated:true,userId:'limit',tenantId:'tenant',role:'admin')))]);addTearDown(c.dispose);final store=c.read(themeLibraryProvider.notifier);for(var i=0;i<20;i++)await store.save(PersonalTheme(name:'Theme $i',preset:'default'));await expectLater(store.save(PersonalTheme(name:'Overflow',preset:'default')),throwsFormatException);expect(c.read(themeLibraryProvider).length,20);
 });
}
