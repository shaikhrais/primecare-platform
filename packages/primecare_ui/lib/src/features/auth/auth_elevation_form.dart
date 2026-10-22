import 'package:intl/intl.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'auth_experience.dart' show PrimeAuthTextField;
import 'auth_elevation_catalog.g.dart';
import 'auth_elevation_controller.dart';
Map<String,String> elevationLabels(BuildContext context)=>authElevationText[Localizations.localeOf(context).languageCode]??authElevationText['en']!;
String supportExpiry(BuildContext context,DateTime deadline){
  final local=deadline.toLocal(),copy=elevationLabels(context),format=MaterialLocalizations.of(context);
  return copy['expires']!.replaceAll('{time}','${format.formatShortDate(local)} ${format.formatTimeOfDay(TimeOfDay.fromDateTime(local))}');
}
class NativeAuthElevationForm extends ConsumerWidget {
 const NativeAuthElevationForm({super.key});
 @override
 Widget build(BuildContext context,WidgetRef ref){
  final state=ref.watch(authElevationProvider),controller=ref.read(authElevationProvider.notifier),theme=context.theme,text=elevationLabels(context);
  if(!state.canUse)return const SizedBox.shrink();
  final gap=SizedBox(height:theme.spacing.lg),children=<Widget>[
   Cy(id:'mfa-elevation-title',child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[Semantics(header:true,child:Text(text['title']!,style:theme.typography.h2)),SizedBox(height:theme.spacing.md),Text(text['scope']!,style:theme.typography.bodyMedium),SizedBox(height:theme.spacing.md),Text(text['privacy']!,style:theme.typography.bodyMedium)])),gap,
  ];
  if(state.elevation==null){
   children.addAll([
    PrimeAuthTextField(id:'mfa-elevation-password',label:text['password']!,password:true,initialValue:state.password,onChanged:controller.password,enabled:!state.working,autofillHints:const [AutofillHints.password]),gap,
    PrimeAuthTextField(id:'mfa-elevation-factor',label:text['factor']!,sensitive:true,initialValue:state.factor,onChanged:controller.factor,enabled:!state.working,keyboardType:TextInputType.number,autofillHints:const [AutofillHints.oneTimeCode]),gap,
    PrimeAuthTextField(id:'mfa-elevation-reason',label:text['reason']!,initialValue:state.reason,onChanged:controller.reason,enabled:!state.working),gap,
    PrimeButton(label:text[state.working?'working':'elevate']!,onPressed:controller.elevate,isLoading:state.working,isFullWidth:true,dataCy:'mfa-elevation-elevate'),
   ]);
  }else{
   children.addAll([Cy(id:'mfa-elevation-status',child:Semantics(liveRegion:true,child:Text(supportExpiry(context,state.request?.expiresAt??state.elevation!.expiresAt),style:theme.typography.bodyMedium))),gap]);
   if(state.request==null){
    children.addAll([
     PrimeAuthTextField(id:'mfa-elevation-tenant',label:text['tenant']!,initialValue:state.tenant,onChanged:controller.tenant,enabled:!state.working),gap,
     PrimeAuthTextField(id:'mfa-elevation-ticket',label:text['ticket']!,initialValue:state.ticket,onChanged:controller.ticket,enabled:!state.working),gap,
     PrimeAuthTextField(id:'mfa-elevation-reason',label:text['reason']!,initialValue:state.reason,onChanged:controller.reason,enabled:!state.working),gap,
     PrimeButton(label:text['request']!,onPressed:state.working?null:controller.requestSupport,isFullWidth:true,dataCy:'mfa-elevation-request'),gap,
    ]);
   }else{
    children.addAll([
     Text(state.failed?text['error']!:state.summary!=null?text['approved']!:text['pending']!,style:theme.typography.bodyMedium),gap,
     PrimeButton(label:text['summary']!,onPressed:state.working?null:controller.readSummary,isFullWidth:true,dataCy:'mfa-elevation-summary'),gap,
     PrimeAuthTextField(id:'mfa-elevation-password',label:text['password']!,password:true,initialValue:state.password,onChanged:controller.password,enabled:!state.working,autofillHints:const [AutofillHints.password]),gap,
     PrimeButton(label:text['cancelSupport']!,onPressed:state.working?null:controller.revokeSupport,isFullWidth:true,dataCy:'mfa-elevation-cancelsupport'),gap,
    ]);
    final summary=state.summary;
    if(summary!=null){
     final numbers=NumberFormat.decimalPattern(Localizations.localeOf(context).languageCode);
     children.addAll([Cy(id:'mfa-elevation-summaryvalues',child:Semantics(container:true,child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
      Text(text['activeAccounts']!.replaceAll('{count}',numbers.format(summary.activeAccounts)),style:theme.typography.bodyMedium),
      Text(text['activeSessions']!.replaceAll('{count}',numbers.format(summary.activeSessions)),style:theme.typography.bodyMedium),
      Text(text['enrolledAuthenticators']!.replaceAll('{count}',numbers.format(summary.enrolledAuthenticators)),style:theme.typography.bodyMedium),
     ]))),gap]);
    }
   }
   children.add(PrimeButton(label:text['revoke']!,onPressed:state.working?null:controller.end,isFullWidth:true,dataCy:'mfa-elevation-revoke'));
  }
  if(state.failed&&state.request==null)children.addAll([gap,Text(text['error']!,style:theme.typography.bodyMedium)]);
  if(state.ended)children.addAll([gap,Text(text['expired']!,style:theme.typography.bodyMedium)]);
  return Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:children);
 }
}
