import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/providers/persistence_providers.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_settings_provider.dart';
import 'package:flutter_core/theme/theme_center_settings_file.dart';
import 'package:flutter_core/registry/widgets/theme_settings_drawer.dart';
import 'package:flutter_core/workspace.dart';
import 'theme_center_test.dart' show TestThemeAuth;

class NavbarDraft extends StatefulWidget {
  const NavbarDraft({super.key});
  @override State<NavbarDraft> createState()=>NavbarDraftState();
}
class NavbarDraftState extends State<NavbarDraft> {
  final controller=TextEditingController();
  @override void dispose(){controller.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>ListView(children:[
    TextField(key:const Key('navbar-draft'),controller:controller),
    for(var i=0;i<80;i++)SizedBox(height:40,child:Text('Existing content $i')),
  ]);
}

void main(){
  test('old appearance files retain legacy behavior; new settings roundtrip separately from toolbar',(){
    const old=ThemeSettingsState(layoutStyle:LayoutStyle.horizontal,presetName:'default',customScrollbars:true,direction:TextDirection.ltr);
    expect(old.toJson()['version'],4);expect(ThemeSettingsState.fromJson(old.toJson()).navbarStyle,isNull);
    final changed=old.copyWith(navbarStyle:'static');
    expect(changed.toJson()['version'],5);
    expect(ThemeSettingsState.fromJson(changed.toJson()).navbarStyle,'static');
    expect(changed.withTheme(PersonalTheme(name:'New palette',preset:'defaultDark')).navbarStyle,'static');
    final layout=WorkspaceLayout.defaults([]).patch({'navigation':'top','toolbarStyle':'sticky'});
    final restored=ThemeCenterSettingsFile.parse(ThemeCenterSettingsFile(appearance:changed,layout:layout).exportJson(),[]);
    expect(restored.appearance.navbarStyle,'static');expect(restored.layout.toolbarStyle,'sticky');
    expect(restored.layout.toJson()['version'],1);expect(restored.layout.toJson().containsKey('navbarStyle'),false);
    for(final bad in ['sticky','script',null]){
      expect(()=>ThemeSettingsState.fromJson({...changed.toJson(),'navbarStyle':bad}),throwsFormatException);
    }
    expect(()=>ThemeSettingsState.fromJson({...changed.toJson(),'role':'admin'}),throwsFormatException);
  });

  test('choice persists per account, survives palette changes, and stale sessions cannot write another account',()async{
    SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();
    AuthState actor(String user)=>AuthState(isAuthenticated:true,userId:user,tenantId:'tenant',role:'admin');
    ProviderContainer container(String user)=>ProviderContainer(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),authProvider.overrideWith(()=>TestThemeAuth(actor(user)))]);
    final a=container('alice');addTearDown(a.dispose);a.read(themeSettingsProvider);
    final notifier=a.read(themeSettingsProvider.notifier),session= a.read(themeSettingsProvider.notifier).bindAccount();
    await notifier.updateNavbarStyle('static');await notifier.updatePreset('defaultDark');
    await notifier.updateSectionTheme('footer',PersonalTheme(name:'Footer',preset:'default'));
    await session.updateTextScale(1.25);
    expect(a.read(themeSettingsProvider).navbarStyle,'static');
    final restarted=container('alice');addTearDown(restarted.dispose);expect(restarted.read(themeSettingsProvider).navbarStyle,'static');
    expect(restarted.read(themeSettingsProvider).theme.fontScale, 1.25);
    (a.read(authProvider.notifier) as TestThemeAuth).switchUser(actor('bob'));
    expect(a.read(themeSettingsProvider).navbarStyle,'fixed');
    expect(()=>session.updateNavbarStyle('static'),throwsStateError);
    expect(()=>session.updateTextScale(1.5),throwsStateError);
    expect(a.read(themeSettingsProvider).theme.fontScale, 1.0);
    expect(a.read(themeSettingsProvider).navbarStyle,'fixed');
    expect(()=>notifier.updateNavbarStyle('unsupported'),throwsArgumentError);
  });

  testWidgets('Navbar Style is visible in the horizontal settings and does not change toolbar state',(tester)async{
    tester.view.physicalSize=const Size(1400,1000);tester.view.devicePixelRatio=1;
    addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();
    late WorkspaceController workspace;
    await tester.pumpWidget(ProviderScope(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),authProvider.overrideWith(()=>TestThemeAuth(AuthState(isAuthenticated:true,userId:'navbar',tenantId:'tenant',role:'admin')))],
      child:MaterialApp(home:PortalWorkspace(scope:WorkspaceScope(tenant:'tenant',user:'navbar',role:'admin'),preferences:SharedWorkspacePreferences(prefs),legacyLayoutStyle:'horizontal',
        builder:(context,c){workspace=c;return const Scaffold(body:Center(child:ThemeSettingsDrawer(tenantDefaultPreset:'default')));}))));
    await tester.pumpAndSettle();
    final group=find.byKey(const Key('theme-navbar-style'));
    expect(group,findsOneWidget);
    await tester.tap(find.descendant(of:group,matching:find.text('Static')));await tester.pumpAndSettle();
    final container=ProviderScope.containerOf(tester.element(group));
    expect(container.read(themeSettingsProvider).navbarStyle,'static');expect(workspace.current.toolbarStyle,'sticky');
    await tester.tap(find.descendant(of:group,matching:find.text('Fixed')));await tester.pumpAndSettle();
    expect(container.read(themeSettingsProvider).navbarStyle,'fixed');expect(workspace.current.toolbarStyle,'sticky');
    // The Fuse baseline has Above/Below; retain the extra Bottom option in Advanced.
    expect(find.text('Bottom'),findsNothing);
    await tester.scrollUntilVisible(find.text('Advanced layout'),400,scrollable:find.byType(Scrollable).first);
    await tester.tap(find.text('Advanced layout'));await tester.pumpAndSettle();
    final advanced=find.ancestor(of:find.text('Advanced layout'),matching:find.byType(ExpansionTile));
    await tester.ensureVisible(find.descendant(of:advanced,matching:find.text('Bottom')));
    await tester.tap(find.descendant(of:advanced,matching:find.text('Bottom')));await tester.pumpAndSettle();
    expect(workspace.current.toolbar,'bottom');
    expect(container.read(themeSettingsProvider).navbarStyle,'fixed');
    expect(tester.takeException(),isNull);
  });

  for(final scroll in ['page','content'])for(final position in ['top','belowNavigation'])for(final toolbarStyle in ['sticky','static'])for(final navbarStyle in ['fixed','static']){
    testWidgets('$scroll / $position / $toolbarStyle toolbar / $navbarStyle navbar scroll independently',(tester)async{
      tester.view.physicalSize=const Size(1500,900);tester.view.devicePixelRatio=1;
      addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
      final c=WorkspaceController(scope:WorkspaceScope(tenant:'tenant',user:'actor',role:'staff'),panelIds:[]);
      addTearDown(c.dispose);c.patch({'navigation':'top','toolbar':position,'toolbarStyle':toolbarStyle,'scroll':scroll,'footer':'hidden'});
      final focus=FocusNode();addTearDown(focus.dispose);
      await tester.pumpWidget(MaterialApp(home:Scaffold(body:PrimeWorkspaceLayout(controller:c,navbarStyle:navbarStyle,horizontalNavigationExtent:48,
        navigation:Focus(focusNode:focus,child:const ColoredBox(color:Colors.blue,child:Text('Authorized navigation'))),
        toolbar:const ColoredBox(color:Colors.green,child:Text('Existing toolbar')),main:const NavbarDraft(),panels:const {}))));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('navbar-draft')),'Keep this draft');
      FocusManager.instance.primaryFocus?.unfocus();await tester.pump();
      final draft=tester.state<NavbarDraftState>(find.byType(NavbarDraft));
      await tester.dragFrom(const Offset(750,500),const Offset(0,-360));await tester.pumpAndSettle();
      final nav=find.byKey(const ValueKey('navbar-scroll-navbar'));
      final tool=find.byKey(const ValueKey('navbar-scroll-toolbar'));
      expect((nav.evaluate().isEmpty?0:tester.getSize(nav).height),navbarStyle=='fixed'?48:0);
      expect((tool.evaluate().isEmpty?0:tester.getSize(tool).height),scroll=='content'||toolbarStyle=='sticky'?56:0);
      expect(focus.context != null && focus.canRequestFocus,navbarStyle=='fixed');
      expect(c.current.toolbarStyle,toolbarStyle);
      expect(tester.state<NavbarDraftState>(find.byType(NavbarDraft)),same(draft));
      await tester.dragFrom(const Offset(750,500),const Offset(0,600));await tester.pumpAndSettle();
      expect(find.text('Keep this draft'),findsOneWidget);
      expect(tester.takeException(),isNull);
    });
  }
}
