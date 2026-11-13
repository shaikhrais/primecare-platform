import 'dart:async' show unawaited;
import 'package:flutter_core/application_modules.dart';
import 'package:flutter_core/dashboard_pages.dart';
import 'package:flutter_core/component_catalogue/prime_component_catalogue.dart' show CatalogueLabels;
import 'package:flutter_core/preference_sync/preference_adapters.dart';
import 'package:flutter_core/shell_utilities.dart' show ShellUtilityLabels;
import 'package:flutter_core/src/network/api_client.dart' show ApiConfig;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'tenant_application_catalog.g.dart';

/// The host owns these clients. Injecting a factory does not supply authority.
final nativeApplicationClientProvider = Provider<http.Client Function()>((ref) => http.Client.new);

class _Identity {
  final String user, tenant, role, token;
  const _Identity(this.user,this.tenant,this.role,this.token);
  PreferenceScope get scope => PreferenceScope(tenant,user,role,'live');
  bool matches(AuthState value) => value.isAuthenticated && value.userId==user &&
      value.tenantId==tenant && value.role==role && value.token==token;
  @override bool operator ==(Object other) => other is _Identity &&
      (user,tenant,role,token)==(other.user,other.tenant,other.role,other.token);
  @override int get hashCode => Object.hash(user,tenant,role,token);
  @override String toString() => 'NativeApplicationIdentity(redacted)';
}

/// Existing screen2534/API16578 authorizes this native composition before either
/// child mounts. Profile remains read-only; account security stays on /success.
class TenantApplicationScreen extends ConsumerWidget {
  const TenantApplicationScreen({super.key});
  @override Widget build(BuildContext context,WidgetRef ref) {
    final auth=ref.watch(authProvider);
    if(!auth.isInitialized || !auth.isAuthenticated || auth.userId?.isNotEmpty!=true ||
        auth.tenantId?.isNotEmpty!=true || auth.token?.isNotEmpty!=true ||
        auth.role!=nativeApplicationDestinations['host']['role']) return const SizedBox.shrink();
    final identity=_Identity(auth.userId!,auth.tenantId!,auth.role!,auth.token!);
    return _ScopedApplications(key:ValueKey(identity),identity:identity);
  }
}

class _ScopedApplications extends ConsumerStatefulWidget {
  final _Identity identity;
  const _ScopedApplications({super.key,required this.identity});
  @override ConsumerState<_ScopedApplications> createState()=>_ApplicationsState();
}
class _ApplicationsState extends ConsumerState<_ScopedApplications> {
  final _clients=<http.Client>[];
  DashboardPageTransport? _dashboard;
  WorkModuleSession? _profile;
  ApplicationShortcutEditor? _editor;
  String _status='loading';
  DateTime? _today;
  int _generation=0;
  bool get _current => mounted && widget.identity.matches(ref.read(authProvider));
  PreferenceScope? _scope() => _current ? widget.identity.scope : null;
  String? _token() => _current ? widget.identity.token : null;
  http.Client _client() {final client=ref.read(nativeApplicationClientProvider)();_clients.add(client);return client;}
  bool get _blocked {final state=_editor?.current;return state!=null &&
      (state['dirty']==true || state['pending']!=null || state['remote']!=null ||
       ['loading','saving','discarding','recovering'].contains(state['status']));}
  @override void initState(){super.initState();Future<void>.microtask(_load);}
  void _retire(){_profile?.dispose();_profile=null;_editor?.dispose();_editor=null;
    _dashboard?.dispose();_dashboard=null;for(final client in _clients){client.close();}_clients.clear();}
  @override void dispose(){_generation++;_retire();super.dispose();}
  Future<void> _load()async{
    if(!_current || _blocked)return;
    final generation=++_generation;_retire();setState(()=>_status='loading');
    bool active()=>_current && generation==_generation;
    try{
      final scope=widget.identity.scope,origin=Uri.parse(ApiConfig.baseUrl.isEmpty?Uri.base.origin:ApiConfig.baseUrl);
      _dashboard=DashboardPageTransport(origin:origin,token:widget.identity.token,scope:scope,
        currentToken:_token,currentScope:_scope,maxBytes:1048576,client:_client());
      final raw=validateDashboardResponseScope(await _dashboard!.read(),scope);
      if(!active())return;
      final today=raw['today'];
      if(today is! String || !RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(today))throw const FormatException();
      final parsed=DateTime.parse(today);
      if(parsed.toIso8601String().substring(0,10)!=today)throw const FormatException();
      final export=nativeApplicationDestinations;
      if(export['host']['screenId']!=2534 || export['host']['role']!=scope.role)throw const FormatException();
      final names=<String,String>{for(final row in export['destinations'] as List)
        row['id'] as String:row['title'] as String};
      final preferences=await SharedPreferences.getInstance();
      if(!active())return;
      final locale=_locale(context),words=Map<String,String>.from(nativeApplicationApplication['locales'][locale] as Map);
      final settings=ApplicationSettingsPort.authenticated(origin:origin,token:widget.identity.token,
        binding:PreferenceBinding(scope:scope,kind:'shortcuts',resource:'navigation',screenIds:names.keys.toList()),
        cache:SharedPreferenceCache(preferences),names:names,labels:words,defaults:const ['2534'],
        currentToken:_token,currentScope:_scope,client:_client());
      _editor=ApplicationShortcutEditor(settings);
      _profile=WorkModuleSession(scope,'profile',port:ApplicationProfilePort(origin:origin,
        token:widget.identity.token,scope:scope,currentToken:_token,currentScope:_scope,
        identityLabel:words['profile']!,client:_client()));
      _today=parsed;
      setState(()=>_status='ready');
      unawaited(_editor!.load());
    }catch(_){if(active()){_retire();setState(()=>_status='unavailable');}}
  }
  String _locale(BuildContext context){final value=Localizations.localeOf(context).languageCode;
    return ['en','fr','es'].contains(value)?value:'en';}
  @override Widget build(BuildContext context){
    final locale=_locale(context),application=CatalogueLabels.fromMetadata(nativeApplicationApplication,locale),
      recovery=CatalogueLabels.fromMetadata(nativeApplicationRecovery,locale);
    final shell=ShellUtilityLabels(Map<String,String>.from(nativeApplicationShell['locales'][locale] as Map),
      {for(final row in nativeApplicationShell['controls'] as List)row['key'] as String:row['testId'] as String});
    final profile=_profile,editor=_editor,today=_today,theme=context.theme;
    return PrimePageScaffold(title:PrimeText(application.text('settings')),
      body:SingleChildScrollView(padding:EdgeInsets.all(theme.spacing.lg),
        child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
          if(_status!='ready')Semantics(liveRegion:true,child:PrimeText(application.text(_status))),
          if(_status=='unavailable')PrimeTextButton(onPressed:_load,child:PrimeText(application.text('reload'))),
          if(profile!=null && editor!=null && today!=null)...[
            PrimeWorkModule(labels:application,session:profile,scope:'${profile.scope.tenantId}:${profile.scope.userId}:${profile.scope.role}:live',
              year:today.year,month:today.month,gap:theme.spacing.md,boardWidth:MediaQuery.sizeOf(context).width),
            SizedBox(height:theme.spacing.lg),
            PrimeApplicationShortcuts(editor:editor,labels:shell,recoveryLabels:recovery),
          ],
        ])));
  }
}
