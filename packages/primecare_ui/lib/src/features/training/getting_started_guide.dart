import 'package:primecare_ui/primecare_ui.dart';
import '../platform/platform_master_screen.dart';
import 'getting_started_catalog.g.dart';

/// Read-only orientation. Domain actions retain their existing server policies.
class GettingStartedGuide extends StatefulWidget {
  final VoidCallback? onDetailedTraining;
  const GettingStartedGuide({super.key,this.onDetailedTraining});
  @override
  State<GettingStartedGuide> createState()=>_GettingStartedGuideState();
}
class _GettingStartedGuideState extends State<GettingStartedGuide>{
  int step=0;
  final scroll=ScrollController();
  void move(int next){setState(()=>step=next);if(scroll.hasClients)scroll.jumpTo(0);}
  @override
  void dispose(){scroll.dispose();super.dispose();}
  @override
  Widget build(BuildContext context){
    final item=gettingStartedSteps[step];
    return Scaffold(appBar:AppBar(title:const Text('Beginner guide')),body:ListView(controller:scroll,padding:const EdgeInsets.all(24),children:[
      Text('Step ${step+1} of ${gettingStartedSteps.length}',style:Theme.of(context).textTheme.labelLarge),
      const SizedBox(height:12),Text(item['title'] as String,style:Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height:16),Text(item['body'] as String),
      const SizedBox(height:16),for(final domain in item['domains'] as List)Padding(padding:const EdgeInsets.only(bottom:8),child:Text('• $domain')),
      Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Try this',style:TextStyle(fontWeight:FontWeight.bold)),const SizedBox(height:8),Text(item['check'] as String)]))),
      const SizedBox(height:16),Image.network('https://primecare-clinic.pages.dev${item['image']}',height:260,fit:BoxFit.contain,semanticLabel:'Example PrimeCare screen using synthetic data',errorBuilder:(_,__,___)=>const Text('Example screenshot is unavailable. Use the instructions above.')),
      const SizedBox(height:8),const Text('Example screenshots use synthetic data. Available menus depend on your role and permissions.'),const SizedBox(height:20),
      Row(children:[OutlinedButton(onPressed:step==0?null:()=>move(step-1),child:const Text('Back')),const Spacer(),FilledButton(onPressed:step==gettingStartedSteps.length-1?null:()=>move(step+1),child:const Text('Next step'))]),
      const SizedBox(height:20),const PlatformAdministrationLauncher(label:'Open dashboard'),
      if(widget.onDetailedTraining!=null)TextButton(onPressed:widget.onDetailedTraining,child:const Text('Detailed training and self-assessment')),
    ]));
  }
}
