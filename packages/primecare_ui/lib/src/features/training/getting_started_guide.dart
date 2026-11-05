import 'package:primecare_ui/primecare_ui.dart';
import '../platform/platform_master_screen.dart';
import 'getting_started_catalog.g.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';

const _guideText = <String, Map<String, String>>{
  'en': {'title': 'Beginner guide', 'back': 'Back', 'next': 'Next step', 'step': 'Step {current} of {total}', 'try': 'Try this', 'image_label': 'Example PrimeCare screen using synthetic data', 'image_unavailable': 'Example screenshot is unavailable. Use the instructions above.', 'image_notice': 'Example screenshots use synthetic data. Available menus depend on your role and permissions.', 'dashboard': 'Open dashboard', 'detail': 'Detailed training and self-assessment'},
  'fr': {'title': 'Guide de démarrage', 'back': 'Retour', 'next': 'Étape suivante', 'step': 'Étape {current} sur {total}', 'try': 'À essayer', 'image_label': 'Exemple d’écran PrimeCare utilisant des données fictives', 'image_unavailable': 'La capture d’écran est indisponible. Suivez les instructions ci-dessus.', 'image_notice': 'Les exemples utilisent des données fictives. Les menus disponibles dépendent de votre rôle et de vos autorisations.', 'dashboard': 'Ouvrir le tableau de bord', 'detail': 'Formation détaillée et autoévaluation'},
  'es': {'title': 'Guía para empezar', 'back': 'Atrás', 'next': 'Siguiente paso', 'step': 'Paso {current} de {total}', 'try': 'Prueba esto', 'image_label': 'Ejemplo de pantalla de PrimeCare con datos ficticios', 'image_unavailable': 'La captura de ejemplo no está disponible. Usa las instrucciones anteriores.', 'image_notice': 'Las capturas de ejemplo usan datos ficticios. Los menús disponibles dependen de tu rol y tus permisos.', 'dashboard': 'Abrir panel', 'detail': 'Formación detallada y autoevaluación'},
};

String _guideLabel(BuildContext context, String key, {Map<String, String> args = const {}}) {
  final language = Localizations.localeOf(context).languageCode;
  final fallback = _guideText[language]?[key] ?? _guideText['en']![key]!;
  return liveScreenText(context, 'getting_started_guide', language, key, fallback, args: args);
}

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
    final original=gettingStartedSteps[step];
    final language=Localizations.localeOf(context).languageCode;
    final item=gettingStartedTranslations[language]?[step] ?? original;
    String lessonText(String field, String fallback) => liveScreenText(context,
      'getting_started_guide',language,'step_${step+1}_$field',fallback);
    final domains=item['domains'] as List;
    return Scaffold(appBar:AppBar(title:Text(_guideLabel(context,'title'))),bottomNavigationBar:SafeArea(child:Padding(padding:const EdgeInsets.all(16),child:Row(children:[OutlinedButton(onPressed:step==0?null:()=>move(step-1),child:Text(_guideLabel(context,'back'))),const Spacer(),FilledButton(onPressed:step==gettingStartedSteps.length-1?null:()=>move(step+1),child:Text(_guideLabel(context,'next')))]))),body:ListView(controller:scroll,padding:const EdgeInsets.all(24),children:[
      Text(_guideLabel(context,'step',args:{'current':'${step+1}','total':'${gettingStartedSteps.length}'}),style:Theme.of(context).textTheme.labelLarge),
      const SizedBox(height:12),Text(lessonText('title',item['title'] as String),style:Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height:16),Text(lessonText('body',item['body'] as String)),
      const SizedBox(height:16),for(var i=0;i<domains.length;i++)Padding(padding:const EdgeInsets.only(bottom:8),child:Text('• ${lessonText('domain_$i',domains[i] as String)}')),
      Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(_guideLabel(context,'try'),style:const TextStyle(fontWeight:FontWeight.bold)),const SizedBox(height:8),Text(lessonText('check',item['check'] as String))]))),
      const SizedBox(height:16),Image.network('https://primecare-clinic.pages.dev${original['image']}',height:260,fit:BoxFit.contain,semanticLabel:_guideLabel(context,'image_label'),errorBuilder:(_,__,___)=>Text(_guideLabel(context,'image_unavailable'))),
      const SizedBox(height:8),Text(_guideLabel(context,'image_notice')),const SizedBox(height:20),
      
      const SizedBox(height:20),PlatformAdministrationLauncher(label:_guideLabel(context,'dashboard')),
      if(widget.onDetailedTraining!=null)TextButton(onPressed:widget.onDetailedTraining,child:Text(_guideLabel(context,'detail'))),
    ]));
  }
}
