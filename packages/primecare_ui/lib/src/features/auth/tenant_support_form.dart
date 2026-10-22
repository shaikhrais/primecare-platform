import 'package:primecare_ui/primecare_ui.dart';
import 'auth_experience.dart' show PrimeAuthTextField;
import 'auth_elevation_form.dart' show elevationLabels,supportExpiry;
import 'auth_elevation_controller.dart';
class NativeTenantSupportForm extends ConsumerWidget {
 const NativeTenantSupportForm({super.key});
 @override
 Widget build(BuildContext context,WidgetRef ref){
  final state=ref.watch(tenantSupportProvider),controller=ref.read(tenantSupportProvider.notifier),text=elevationLabels(context),theme=context.theme;
  if(!state.canUse)return const SizedBox.shrink();
  final gap=SizedBox(height:theme.spacing.lg),children=<Widget>[
   Cy(id:'mfa-elevation-approvaltitle',child:Semantics(header:true,child:Text(text['approvalTitle']!,style:theme.typography.h2))),gap,
   Text(text['privacy']!,style:theme.typography.bodyMedium),gap,
   PrimeButton(label:text[state.working?'working':'refresh']!,onPressed:state.working?null:controller.refresh,isLoading:state.working,isFullWidth:true,dataCy:'mfa-elevation-refresh'),gap,
   PrimeAuthTextField(id:'mfa-elevation-approvalpassword',label:text['approvalPassword']!,password:true,initialValue:state.password,onChanged:controller.password,enabled:!state.working,autofillHints:const [AutofillHints.password]),gap,
  ];
  final rows=<Widget>[];
  if(!state.working&&state.requests.isEmpty)rows.add(Text(text['none']!,style:theme.typography.bodyMedium));
  for(final request in state.requests){
   rows.addAll([
    Text('${text['ticket']} ${request.ticket}',style:theme.typography.bodyLarge),
    Text('${text['requester']} ${request.requesterId}',style:theme.typography.bodyMedium),
    Text('${text['tenant']} ${request.tenantId}',style:theme.typography.bodyMedium),
    Text('${text['reason']} ${request.reason}',style:theme.typography.bodyMedium),
    Text(supportExpiry(context,request.expiresAt),style:theme.typography.bodyMedium),gap,
    if(request.status=='pending')PrimeButton(label:text['approve']!,onPressed:state.working?null:()=>controller.decide(request,approve:true),isFullWidth:true,dataCy:'mfa-elevation-approve-${request.id}'),
    if(request.status=='approved')Text(text['approved']!,style:theme.typography.bodyMedium),gap,
    PrimeButton(label:text['reject']!,onPressed:state.working?null:()=>controller.decide(request,approve:false),isFullWidth:true,dataCy:'mfa-elevation-reject-${request.id}'),gap,
   ]);
  }
  children.add(Cy(id:'mfa-elevation-approvalrequests',child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:rows)));
  if(state.failed)children.add(Text(text['error']!,style:theme.typography.bodyMedium));
  return Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:children);
 }
}
