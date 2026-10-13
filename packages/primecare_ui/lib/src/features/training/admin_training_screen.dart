import 'package:flutter_core/src/localization/live_screen_text.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../reports/report_pdf_exporter.dart';
import 'admin_training_progress.dart';
import 'admin_training_pdf.dart';
import 'localization/admin_training_catalog_generated.dart';
import 'models/admin_training_lesson.dart';

class AdminTrainingScreen extends ConsumerStatefulWidget {
  final String actor, gateway;
  final AdminTrainingProgress? progress;
  final ReportPdfExporter? exporter;
  const AdminTrainingScreen({super.key,required this.actor,required this.gateway,
    this.progress,this.exporter});
  @override
  ConsumerState<AdminTrainingScreen> createState() => _AdminTrainingState();
}
class _AdminTrainingState extends ConsumerState<AdminTrainingScreen> {
  late final AdminTrainingProgress _progress;
  List<AdminTrainingResult> _results = [];
  AdminTrainingLesson _lesson = adminTrainingLessons.first;
  String? _locale;
  int? _answer;
  String? _notice;
  bool _busy = true;
  String get locale => _locale ?? 'en';
  String text(String key) => liveScreenText(context,'admin_training',locale,key,
    adminTrainingCatalog[locale]?[key] ?? adminTrainingCatalog['en']![key]!);
  @override
  void initState() {
    super.initState();
    _progress = widget.progress ?? AdminTrainingProgress(gateway:widget.gateway,actor:widget.actor);
    Future.microtask(() async {
      final records = await _progress.results();
      if (mounted) setState(() { _results=records; _busy=false; });
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final language=Localizations.localeOf(context).languageCode;
    _locale ??= adminTrainingCatalog.containsKey(language) ? language : 'en';
  }
  Future<void> submit() async {
    if (_busy) return;
    if (_answer == null) { setState(() { _notice='select_answer'; }); return; }
    setState(() { _busy=true; });
    try {
      final passed=await _progress.answer(_lesson.id,_answer!);
      final records=await _progress.results();
      if (mounted) setState(() { _results=records; _notice=passed?'correct':'incorrect'; });
    } catch (_) { if(mounted)setState(() { _notice='storage_error'; }); }
    finally { if(mounted)setState(() { _busy=false; }); }
  }
  Future<void> reset() async {
    if (_busy) return;
    final confirmed=await showDialog<bool>(context:context,builder:(context)=>AlertDialog(
      title:Text(text('reset_confirm')),actions:[
        TextButton(onPressed:()=>Navigator.pop(context,false),child:Text(text('close'))),
        TextButton(onPressed:()=>Navigator.pop(context,true),child:Text(text('reset'))),
      ]));
    if (confirmed != true || !mounted) return;
    setState(() { _busy=true; });
    try { await _progress.reset();if(mounted)setState(() { _results=[];_notice=null; }); }
    catch (_) { if(mounted)setState(() { _notice='storage_error'; }); }
    finally { if(mounted)setState(() { _busy=false; }); }
  }
  Future<void> export() async {
    if (_busy) return;
    setState(() { _busy=true; });
    try {
      final bytes=await AdminTrainingPdf.render(await _progress.summary(),locale);
      final saved=await (widget.exporter ?? ReportPdfExporter()).export(bytes,'PrimeCare-Admin-Training-Summary.pdf');
      if(mounted)setState(() { _notice=saved?'export_saved':'export_cancelled'; });
    } catch (_) { if(mounted)setState(() { _notice='export_error'; }); }
    finally { if(mounted)setState(() { _busy=false; }); }
  }
  Widget button(String labelKey,String id,VoidCallback action,{bool selected=false}) => Semantics(
    label:id,selected:selected,child:PrimeButton(key:ValueKey(id),dataCy:id,
      label:text(labelKey),isGhost:!selected,onPressed:_busy?null:action));
  @override
  Widget build(BuildContext context) {
    final spacing=context.theme.spacing;
    final auth=ref.watch(authProvider);
    if(!auth.isInitialized || !auth.isAuthenticated || auth.userId!=widget.actor) {
      return Scaffold(appBar:AppBar(title:Text(text('title'))),body:Center(child:Text(text('scope'))));
    }
    return Scaffold(appBar:AppBar(title:Text(text('title'))),body:Semantics(
      label:'screen-admin-training',container:true,child:ListView(padding:EdgeInsets.all(spacing.lg),children:[
        Text(text('scope')),SizedBox(height:spacing.md),Text(text('local_note')),
        SizedBox(height:spacing.md),Text(text('safety')),
        if(_busy)const LinearProgressIndicator(),
        SizedBox(height:spacing.md),Text(text('language')),
        Wrap(spacing:spacing.sm,runSpacing:spacing.sm,children:[for(final language in ['en','fr','es'])
          button('language_$language','training-language-$language',()=>setState(() { _locale=language; }),selected:locale==language)]),
        SizedBox(height:spacing.md),Semantics(label:'training-progress',child:Text('${text('progress')}: ${_results.length}/${adminTrainingLessons.length}')),
        if(_results.length==adminTrainingLessons.length)Semantics(label:'training-complete',child:Text(text('complete'))),
        SizedBox(height:spacing.md),Wrap(spacing:spacing.sm,runSpacing:spacing.sm,children:[
          for(final lesson in adminTrainingLessons)Semantics(label:'training-lesson-${lesson.id}',selected:lesson.id==_lesson.id,child:PrimeButton(
            key:ValueKey('training-lesson-${lesson.id}'),dataCy:'training-lesson-${lesson.id}',
            label:'${text(lesson.titleKey)} · ${text(_results.any((r)=>r.lesson==lesson.id)?'passed':'pending')}',
            isGhost:lesson.id!=_lesson.id,onPressed:_busy?null:()=>setState(() { _lesson=lesson;_answer=null;_notice=null; }))),
        ]),SizedBox(height:spacing.lg),
        Semantics(header:true,child:Text(text(_lesson.titleKey),style:context.theme.typography.h3)),
        SizedBox(height:spacing.md),Text(text('procedure'),style:context.theme.typography.labelBold),Text(text(_lesson.procedureKey)),
        SizedBox(height:spacing.md),Text(text('practice'),style:context.theme.typography.labelBold),Text(text(_lesson.practiceKey)),
        SizedBox(height:spacing.md),Semantics(header:true,child:Text(text(_lesson.questionKey))),
        for(var index=0;index<_lesson.optionKeys.length;index++)Padding(padding:EdgeInsets.symmetric(vertical:spacing.sm),child:
          button(_lesson.optionKeys[index],'training-answer-$index',()=>setState(() { _answer=index; }),selected:_answer==index)),
        button('submit','training-submit',submit),
        if(_notice!=null)Semantics(label:'training-status',liveRegion:true,child:Text(text(_notice!))),
        SizedBox(height:spacing.md),Text(text('export_scope')),SizedBox(height:spacing.md),
        Wrap(spacing:spacing.sm,runSpacing:spacing.sm,children:[button('export_pdf','training-export',export),button('reset','training-reset',reset)]),
      ])));
  }
}
