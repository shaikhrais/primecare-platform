import 'package:flutter_core/theme/theme_center_settings_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/theme/theme_center_complete_panel.dart';
import 'package:flutter_core/workspace/portal_workspace.dart';
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
  await a.read(themeSettingsProvider.notifier).updateSectionTheme('footer',PersonalTheme(name:'Footer',preset:'default',colors:{'surface':'#111827','background':'#111827'}));
  final restarted=container('actor-a','admin');addTearDown(restarted.dispose);expect(restarted.read(themeLibraryProvider).length,2);expect(restarted.read(themeSettingsProvider).theme.fontScale,1.25);expect(restarted.read(themeSettingsProvider).layoutStyle,LayoutStyle.verticalRight);expect(restarted.read(themeSettingsProvider).sectionThemes['footer']!.colors['surface'],'#111827');
  final b=container('actor-b','admin');addTearDown(b.dispose);expect(b.read(themeLibraryProvider),isEmpty);expect(b.read(themeSettingsProvider).theme.colors,isEmpty);expect(b.read(themeSettingsProvider).sectionThemes,isEmpty);
  final role=container('actor-a','rmt');addTearDown(role.dispose);expect(role.read(themeLibraryProvider),isEmpty);
  final notifier=a.read(authProvider.notifier) as TestThemeAuth;notifier.switchUser(actor('actor-b','admin'));expect(a.read(themeLibraryProvider),isEmpty);expect(a.read(themeSettingsProvider).theme.colors,isEmpty);
  await restarted.read(themeLibraryProvider.notifier).remove(id);expect(restarted.read(themeLibraryProvider).length,1);
 });
 test('malformed stored preferences fall back without applying them',()async{
  final auth=AuthState(isAuthenticated:true,userId:'bad',tenantId:'tenant',role:'admin');final scope=themeAccountScope(auth);SharedPreferences.setMockInitialValues({'theme_center_settings_v1:$scope':jsonEncode({'version':2}),'theme_center_library_v1:$scope':'not json'});final prefs=await SharedPreferences.getInstance();final c=ProviderContainer(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),authProvider.overrideWith(()=>TestThemeAuth(auth))]);addTearDown(c.dispose);expect(c.read(themeSettingsProvider).theme.colors,isEmpty);expect(c.read(themeLibraryProvider),isEmpty);
 });
 testWidgets('complete Save all and Load all restore layout and section palettes together',(tester)async{
  SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();
  late WorkspaceController workspace;
  await tester.pumpWidget(ProviderScope(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),
    authProvider.overrideWith(()=>TestThemeAuth(AuthState(isAuthenticated:true,userId:'all-settings',tenantId:'tenant',role:'admin')))],
    child:MaterialApp(home:PortalWorkspace(scope:WorkspaceScope(tenant:'tenant',user:'all-settings',role:'admin'),
      preferences:SharedWorkspacePreferences(prefs),legacyLayoutStyle:'verticalLeft',
      builder:(context,c){workspace=c;return const Scaffold(body:SingleChildScrollView(child:ThemeCenterCompletePanel()));}))));
  await tester.pumpAndSettle();
  final container=ProviderScope.containerOf(tester.element(find.byType(ThemeCenterCompletePanel)));
  final settings=container.read(themeSettingsProvider.notifier);
  workspace.patch({'navigation':'right','toolbar':'belowNavigation'});
  await settings.updateSectionTheme('footer',PersonalTheme(name:'Footer',preset:'default',colors:{'surface':'#111827','background':'#111827'}));
  await tester.pumpAndSettle();await tester.ensureVisible(find.text('Save all'));await tester.tap(find.text('Save all'));await tester.pumpAndSettle();
  workspace.patch({'navigation':'hidden'});await settings.updateSectionTheme('footer',null);
  await tester.pumpAndSettle();await tester.ensureVisible(find.text('Load all'));await tester.tap(find.text('Load all'));await tester.pumpAndSettle();
  expect(workspace.current.navigation,'right');expect(workspace.current.toolbar,'belowNavigation');
  expect(container.read(themeSettingsProvider).sectionThemes['footer']!.colors['surface'],'#111827');
  expect(tester.takeException(),isNull);
 });
 test('appearance keys cannot collide and guests never persist a profile',()async{
  AuthState actor(String tenant,String user)=>AuthState(isAuthenticated:true,tenantId:tenant,userId:user,role:'admin');
  final a=actor('a:b','c'),b=actor('a','b:c');
  expect(themeAccountScope(a),isNot(themeAccountScope(b)));expect(legacyThemeAccountScope(a),isNull);
  SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();
  final guest=ProviderContainer(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),
    authProvider.overrideWith(()=>TestThemeAuth(AuthState(isAuthenticated:false,tenantId:'tenant',role:'admin')))]);
  addTearDown(guest.dispose);
  await guest.read(themeSettingsProvider.notifier).updateSectionTheme('footer',PersonalTheme(name:'Preview',preset:'default'));
  expect(prefs.getKeys(),isEmpty);expect(guest.read(themeLibraryProvider),isEmpty);
 });
 testWidgets('each user owns Save Load and imported settings; other users stay unchanged',(tester)async{
  SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();
  late WorkspaceController workspace;late ProviderContainer container;
  Future<void> mount(String user)async{
    await tester.pumpWidget(ProviderScope(key:ValueKey(user),overrides:[sharedPreferencesProvider.overrideWithValue(prefs),
      authProvider.overrideWith(()=>TestThemeAuth(AuthState(isAuthenticated:true,userId:user,tenantId:'tenant',role:'admin')))],
      child:MaterialApp(home:PortalWorkspace(key:ValueKey(user),scope:WorkspaceScope(tenant:'tenant',user:user,role:'admin'),
        preferences:SharedWorkspacePreferences(prefs),legacyLayoutStyle:'verticalLeft',
        builder:(context,c){workspace=c;return const Scaffold(body:SingleChildScrollView(child:ThemeCenterCompletePanel()));}))));
    await tester.pumpAndSettle();container=ProviderScope.containerOf(tester.element(find.byType(ThemeCenterCompletePanel)));
  }
  Future<void> press(String text)async{await tester.ensureVisible(find.text(text));await tester.tap(find.text(text));await tester.pumpAndSettle();}
  await mount('alice');workspace.patch({'navigation':'right'});
  await container.read(themeSettingsProvider.notifier).updateSectionTheme('footer',PersonalTheme(name:'Alice footer',preset:'default'));
  await tester.pumpAndSettle();await press('Save all');
  final aliceKey='theme_center_complete_v1:${workspace.scope.storageKey}',alice=prefs.getString('theme_center_complete_v1:${workspace.scope.storageKey}')!;
  await mount('bob');expect(workspace.current.navigation,'left');expect(container.read(themeSettingsProvider).sectionThemes,isEmpty);
  await press('Load all');expect(workspace.current.navigation,'left');
  await press('Paste all settings');
  await tester.enterText(find.byType(TextField),alice);await tester.tap(find.text('Apply'));await tester.pumpAndSettle();
  expect(workspace.current.navigation,'right');await press('Save all');
  expect(prefs.getString(aliceKey),alice);
  final bobFile=prefs.getString('theme_center_complete_v1:${workspace.scope.storageKey}')!;
  expect(ThemeCenterSettingsFile.parse(bobFile,[]).layout.navigation,'right');
  workspace.patch({'navigation':'hidden'});await press('Save all');
  await mount('alice');await press('Load all');expect(workspace.current.navigation,'right');
  expect(container.read(themeSettingsProvider).sectionThemes['footer']!.name,'Alice footer');
  expect(tester.takeException(),isNull);
 });
 test('dialogs bound to a previous user cannot modify the current account',()async{
  SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();
  AuthState actor(String user)=>AuthState(isAuthenticated:true,userId:user,tenantId:'tenant',role:'admin');
  final c=ProviderContainer(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),authProvider.overrideWith(()=>TestThemeAuth(actor('alice')))]);addTearDown(c.dispose);
  final appearance=c.read(themeSettingsProvider.notifier).bindAccount(),library=c.read(themeLibraryProvider.notifier).bindAccount();
  (c.read(authProvider.notifier) as TestThemeAuth).switchUser(actor('bob'));
  expect(()=>appearance.applyPersonalTheme(PersonalTheme(name:'Old dialog',preset:'default')),throwsStateError);
  expect(()=>library.save(PersonalTheme(name:'Old dialog',preset:'default')),throwsStateError);
  expect(c.read(themeSettingsProvider).sectionThemes,isEmpty);expect(c.read(themeLibraryProvider),isEmpty);expect(prefs.getKeys(),isEmpty);
 });
 test('unambiguous existing account settings remain readable after key migration',()async{
  final auth=AuthState(isAuthenticated:true,userId:'existing',tenantId:'tenant',role:'admin');
  final settings=ThemeSettingsState(layoutStyle:LayoutStyle.verticalRight,presetName:'default',customScrollbars:true,direction:TextDirection.rtl);
  SharedPreferences.setMockInitialValues({'theme_center_settings_v1:${legacyThemeAccountScope(auth)}':jsonEncode(settings.toJson())});
  final prefs=await SharedPreferences.getInstance(),c=ProviderContainer(overrides:[sharedPreferencesProvider.overrideWithValue(await SharedPreferences.getInstance()),authProvider.overrideWith(()=>TestThemeAuth(auth))]);addTearDown(c.dispose);
  expect(c.read(themeSettingsProvider).layoutStyle,LayoutStyle.verticalRight);
  await c.read(themeSettingsProvider.notifier).updatePreset('navyTealPalette');
  expect(prefs.containsKey('theme_center_settings_v1:${themeAccountScope(auth)}'),true);
 });
 test('theme limit leaves existing library intact',()async{
  SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();final c=ProviderContainer(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),authProvider.overrideWith(()=>TestThemeAuth(AuthState(isAuthenticated:true,userId:'limit',tenantId:'tenant',role:'admin')))]);addTearDown(c.dispose);final store=c.read(themeLibraryProvider.notifier);for(var i=0;i<20;i++)await store.save(PersonalTheme(name:'Theme $i',preset:'default'));await expectLater(store.save(PersonalTheme(name:'Overflow',preset:'default')),throwsFormatException);expect(c.read(themeLibraryProvider).length,20);
 });
}
