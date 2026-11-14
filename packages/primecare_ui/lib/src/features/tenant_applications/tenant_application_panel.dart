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
import 'package:go_router/go_router.dart';
import 'tenant_application_catalog.g.dart';

/// The host owns these clients. Injecting a factory does not supply authority.
final nativeApplicationClientProvider = Provider<http.Client Function()>((ref) => http.Client.new);

class NativeApplicationIdentity {
  final String user, tenant, role, token;
  const NativeApplicationIdentity(this.user,this.tenant,this.role,this.token);
  PreferenceScope get scope => PreferenceScope(tenant,user,role,'live');
  bool matches(AuthState value) => value.isAuthenticated && value.userId==user &&
      value.tenantId==tenant && value.role==role && value.token==token;
  @override bool operator ==(Object other) => other is NativeApplicationIdentity &&
      (user,tenant,role,token)==(other.user,other.tenant,other.role,other.token);
  @override int get hashCode => Object.hash(user,tenant,role,token);
  @override String toString() => 'NativeApplicationIdentity(redacted)';
}

class TenantApplicationPanel extends ConsumerStatefulWidget {
  final NativeApplicationIdentity identity;
  const TenantApplicationPanel({super.key,required this.identity});
  @override ConsumerState<TenantApplicationPanel> createState()=>_ApplicationsState();
}
class _ApplicationsState extends ConsumerState<TenantApplicationPanel> {
  final _clients=<http.Client>[];
  DashboardPageTransport? _dashboard;
  WorkModuleSession? _profile;
  ApplicationShortcutEditor? _editor;
  String _status='loading';
  DateTime? _today;
  Map<String,dynamic>? _source;
  DashboardPageProjection? _project,_analytics;
  RecordPageProjection? _activity,_records;
  final _recordSearch=TextEditingController();
  int _generation=0;
  bool _disposed=false;
  bool get _current => !_disposed && mounted && widget.identity.matches(ref.read(authProvider));
  PreferenceScope? _scope() => _current ? widget.identity.scope : null;
  String? _token() => _current ? widget.identity.token : null;
  http.Client _client() {final client=ref.read(nativeApplicationClientProvider)();_clients.add(client);return client;}
  bool get _blocked {final state=_editor?.current;return state!=null &&
      (state['dirty']==true || state['pending']!=null || state['remote']!=null ||
       ['loading','saving','discarding','recovering'].contains(state['status']));}
  @override void initState(){super.initState();Future<void>.microtask(_load);}
  void _changed(){if(_current)setState((){});}
  void _cleanup(Iterable<void Function()> actions){
    Object? firstError;StackTrace? firstStack;
    for(final action in actions){try{action();}catch(error,stack){firstError??=error;firstStack??=stack;}}
    if(firstError!=null)Error.throwWithStackTrace(firstError,firstStack!);
  }
  void _reportCleanup(Object error,StackTrace stack)=>FlutterError.reportError(FlutterErrorDetails(
    exception:error,stack:stack,library:'PrimeCare',context:ErrorDescription('retiring an owned application host')));
  void _retire(){
    final profile=_profile,editor=_editor,dashboard=_dashboard,clients=List<http.Client>.of(_clients);
    _profile=null;_editor=null;_dashboard=null;_clients.clear();
    _source=null;_project=null;_analytics=null;_activity=null;_records=null;
    _cleanup([()=>profile?.dispose(),()=>editor?.removeListener(_changed),()=>editor?.dispose(),
      ()=>dashboard?.dispose(),for(final client in clients)client.close]);
  }
  @override void dispose(){
    _disposed=true;_generation++;
    try{_cleanup([_retire,_recordSearch.dispose,()=>super.dispose()]);}
    catch(error,stack){_reportCleanup(error,stack);}
  }
  Future<void> _load()async{
    if(!_current || _blocked)return;
    final generation=++_generation;
    bool active()=>_current && generation==_generation;
    try{_retire();}catch(error,stack){
      if(active())setState(()=>_status='unavailable');
      _reportCleanup(error,stack);return;
    }
    setState(()=>_status='loading');
    try{
      final scope=widget.identity.scope,origin=Uri.parse(ApiConfig.baseUrl.isEmpty?Uri.base.origin:ApiConfig.baseUrl);
      _dashboard=DashboardPageTransport(origin:origin,token:widget.identity.token,scope:scope,
        currentToken:_token,currentScope:_scope,maxBytes:1048576,client:_client());
      final raw=validateDashboardResponseScope(await _dashboard!.read(),scope);
      if(!active())return;
      final project=DashboardPageProjection.fromResponse('project',raw,scope),analytics=DashboardPageProjection.fromResponse('analytics',raw,scope);
      final activity=RecordPageProjection.fromResponse('activity',raw,scope),records=RecordPageProjection.fromResponse('search',raw,scope,query:_recordSearch.text);
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
      _editor=ApplicationShortcutEditor(settings)..addListener(_changed);
      _profile=WorkModuleSession(scope,'profile',port:ApplicationProfilePort(origin:origin,
        token:widget.identity.token,scope:scope,currentToken:_token,currentScope:_scope,
        identityLabel:words['profile']!,client:_client()));
      _today=parsed;_source=Map.unmodifiable(raw);_project=project;_analytics=analytics;_activity=activity;_records=records;
      setState(()=>_status='ready');
      unawaited(_editor!.load());
    }catch(_){if(active()){
      try{_retire();}catch(error,stack){_reportCleanup(error,stack);}
      if(active())setState(()=>_status='unavailable');
    }}
  }
  String _locale(BuildContext context){final value=Localizations.localeOf(context).languageCode;
    return ['en','fr','es'].contains(value)?value:'en';}
  @override Widget build(BuildContext context){
    final locale=_locale(context),application=CatalogueLabels.fromMetadata(nativeApplicationApplication,locale),
      recovery=CatalogueLabels.fromMetadata(nativeApplicationRecovery,locale);
    final shell=ShellUtilityLabels(Map<String,String>.from(nativeApplicationShell['locales'][locale] as Map),
      {for(final row in nativeApplicationShell['controls'] as List)row['key'] as String:row['testId'] as String});
    final profile=_profile,editor=_editor,today=_today,theme=context.theme;
    final readLabels=<String,String>{for(final entry in (nativeApplicationDashboard['resources'] as Map).entries)
      (entry.key as String).substring('dashboardPages.'.length):(entry.value as Map)[locale] as String,
      'live':nativeApplicationTenant['labels']['live'] as String,'demo':nativeApplicationTenant['labels']['demo'] as String,
      'bounded':nativeApplicationDashboard['resources']['dashboardPages.partial'][locale] as String};
    Widget readView(String key,Widget child)=>Semantics(container:true,identifier:
      (nativeApplicationDashboard['controls'] as List).singleWhere((row)=>row['key']==key)['testId'] as String,child:child);
    return PrimePageScaffold(title:PrimeText(application.text('settings')),
      body:SingleChildScrollView(padding:EdgeInsets.all(theme.spacing.lg),
        child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
          application.identify('open','prime_button',PrimeTextButton(
            onPressed:()=>context.go('/success?enable-semantics=true'),
            child:PrimeText('${application.text('open')} ${application.text('profile')}')),suffix:'-account'),
          if(_status!='ready')Semantics(liveRegion:true,child:PrimeText(application.text(_status))),
          if(_status=='unavailable')PrimeTextButton(onPressed:_load,child:PrimeText(application.text('reload'))),
          if(profile!=null && editor!=null && today!=null)...[
            PrimeWorkModule(labels:application,session:profile,scope:'${profile.scope.tenantId}:${profile.scope.userId}:${profile.scope.role}:live',
              year:today.year,month:today.month,gap:theme.spacing.md,boardWidth:MediaQuery.sizeOf(context).width),
            SizedBox(height:theme.spacing.lg),
            PrimeApplicationShortcuts(editor:editor,labels:shell,recoveryLabels:recovery),
            SizedBox(height:theme.spacing.lg),
            application.identify('reload','prime_button',PrimeTextButton(onPressed:_blocked?null:_load,
              child:PrimeText(application.text('reload'))),suffix:'-dashboard'),
            if(_project!=null)readView('project',PrimeDashboardPage(projection:_project!,labels:readLabels)),
            if(_analytics!=null)readView('analytics',PrimeDashboardPage(projection:_analytics!,labels:readLabels)),
            if(_activity!=null)readView('activity',PrimeRecordPage(projection:_activity!,labels:readLabels)),
            application.identify('filter','prime_text_field',PrimeTextField(controller:_recordSearch,maxLength:100,
              decoration:InputDecoration(labelText:readLabels['search']),onChanged:(value){
                if(!_current||_source==null)return;
                var query=value;
                // TextField limits graphemes; the shared API projection bounds UTF-16 units.
                if(query.length>100){
                  var end=100;final last=query.codeUnitAt(99);
                  if(last>=0xD800&&last<=0xDBFF)end--;
                  query=query.substring(0,end);
                  _recordSearch.value=TextEditingValue(text:query,selection:TextSelection.collapsed(offset:query.length));
                }
                setState(()=>_records=RecordPageProjection.fromResponse('search',_source,widget.identity.scope,query:query));
              }),suffix:'-dashboard-search'),
            if(_records!=null)readView('search',PrimeRecordPage(projection:_records!,labels:readLabels)),
          ],
        ])));
  }
}
