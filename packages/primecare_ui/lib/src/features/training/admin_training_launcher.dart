import 'getting_started_guide.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'admin_training_screen.dart';
import 'localization/admin_training_catalog_generated.dart';

/// Existing verified identity scopes local learning; never grants domain access.
class AdminTrainingLauncher extends ConsumerWidget {
  final bool compact;
  const AdminTrainingLauncher({super.key,this.compact=false});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final auth=ref.watch(authProvider);
    final actor=auth.userId;
    if(!auth.isInitialized || !auth.isAuthenticated || actor==null || actor.trim().isEmpty) return const SizedBox.shrink();
    final locale=Localizations.localeOf(context).languageCode;
    final trainingLabel=liveScreenText(context,'admin_training',locale,'nav',adminTrainingCatalog[locale]?['nav']??adminTrainingCatalog['en']!['nav']!);
    final label={'en':'Beginner guide','fr':'Guide de démarrage','es':'Guía para empezar'}[locale]??trainingLabel;
    void open() => Navigator.of(context).push(MaterialPageRoute<void>(builder:(_)=>GettingStartedGuide(onDetailedTraining:()=>Navigator.of(context).push(MaterialPageRoute<void>(builder:(_)=>AdminTrainingScreen(actor:actor,gateway:ApiConfig.baseUrl))))));
    if(compact)return Semantics(label:'workspace-training',child:IconButton(key:const ValueKey('workspace-training'),tooltip:label,icon:const Icon(Icons.school_outlined),onPressed:open));
    return Semantics(label:'workspace-training',child:PrimeButton(key:const ValueKey('workspace-training'),dataCy:'workspace-training',label:label,onPressed:open));
  }
}
