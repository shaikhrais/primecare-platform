import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/providers/persistence_providers.dart';
import 'package:flutter_core/registry/widgets/theme_settings_drawer.dart';
import 'package:flutter_core/theme/prime_palette_editor.dart';
import 'package:flutter_core/theme/theme_settings_provider.dart';
import 'package:flutter_core/workspace/portal_workspace.dart';
import 'package:flutter_core/workspace/workspace_layout.dart';
import 'theme_center_test.dart' show TestThemeAuth;

void main(){
  test('slide/tabbed settings migrate from older files and survive a roundtrip',(){
    const value=ThemeSettingsState(layoutStyle:LayoutStyle.verticalLeft,presetName:'default',customScrollbars:true,direction:TextDirection.ltr,navigationStyle:'tabbed');
    expect(ThemeSettingsState.fromJson(value.toJson()).navigationStyle,'tabbed');
    final v2=value.toJson()..remove('navigationStyle')..remove('hiddenChrome');v2['version']=2;
    expect(ThemeSettingsState.fromJson(v2).navigationStyle,'slide');
    expect(()=>ThemeSettingsState.fromJson({...value.toJson(),'navigationStyle':'unregistered'}),throwsFormatException);
    expect(WorkspaceLayout.defaults([]).patch({'toolbar':'hidden'}).toolbar,'hidden');
    final remembered=value.copyWith(hiddenChrome:const {'toolbar':'belowNavigation','footer':'static'});
    expect(ThemeSettingsState.fromJson(remembered.toJson()).hiddenChrome,remembered.hiddenChrome);
    expect(()=>ThemeSettingsState.fromJson({...remembered.toJson(),'hiddenChrome':{'role':'admin'}}),throwsFormatException);
  });
  testWidgets('grouped settings persist navigation style and palette editing',(tester)async{
    SharedPreferences.setMockInitialValues({});final preferences=await SharedPreferences.getInstance();
    await tester.pumpWidget(ProviderScope(overrides:[sharedPreferencesProvider.overrideWithValue(preferences),authProvider.overrideWith(()=>TestThemeAuth(
      AuthState(isAuthenticated:true,userId:'preview',tenantId:'tenant',role:'admin',preferredLanguage:'en')))],child:MaterialApp(home:PortalWorkspace(
        scope:WorkspaceScope(tenant:'tenant',user:'preview',role:'admin'),preferences:SharedWorkspacePreferences(preferences),legacyLayoutStyle:'verticalLeft',
        builder:(context,c)=>const Scaffold(body:Center(child:ThemeSettingsDrawer(tenantDefaultPreset:'default')))))));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byWidgetPredicate((w)=>w is Drawer)).width,380);
    await tester.scrollUntilVisible(find.text('Tabbed'),200,scrollable:find.byType(Scrollable).first);await tester.pumpAndSettle();await tester.tap(find.text('Tabbed'));await tester.pumpAndSettle();
    final container=ProviderScope.containerOf(tester.element(find.byType(ThemeSettingsDrawer)));
    expect(container.read(themeSettingsProvider).navigationStyle,'tabbed');
    await tester.scrollUntilVisible(find.byKey(const Key('palette-main')),200,scrollable:find.byType(Scrollable).first);await tester.pumpAndSettle();await tester.tap(find.byKey(const Key('palette-main')));await tester.pumpAndSettle();
    expect(find.text('Edit palette'),findsOneWidget);expect(find.text('Preview'),findsOneWidget);
    await tester.enterText(find.byKey(const Key('palette-color-primary')),'#112233');
    await tester.pump();await tester.tap(find.descendant(of:find.byType(Dialog),matching:find.text('Save')));await tester.pumpAndSettle();
    expect(container.read(themeSettingsProvider).theme.colors['primary'],'#112233');
    expect(container.read(themeSettingsProvider).navigationStyle,'tabbed');
    expect(tester.takeException(),isNull);
  });
  testWidgets('tabbed navigation and hidden-toolbar recovery remain usable',(tester)async{
    final scaffold=GlobalKey<ScaffoldState>();
    await tester.pumpWidget(MaterialApp(home:Scaffold(key:scaffold,endDrawer:const Drawer(child:Text('Theme settings open')),
      body:PrimeWorkspaceRecovery(show:true,child:SizedBox(width:248,child:PrimeTabbedNavigation(tabs:[
        PrimeNavigationTab(label:'Operations',icon:Icons.home,content:const Text('Operations routes'),entries:const []),
        PrimeNavigationTab(label:'Reports',icon:Icons.bar_chart,content:const Text('Report routes'),entries:const []),
      ]))))));
    await tester.tap(find.byTooltip('Reports'));await tester.pump();expect(find.text('Report routes'),findsOneWidget);
    await tester.tap(find.byTooltip('Theme settings'));await tester.pumpAndSettle();expect(find.text('Theme settings open'),findsOneWidget);
    expect(tester.takeException(),isNull);
  });
}
