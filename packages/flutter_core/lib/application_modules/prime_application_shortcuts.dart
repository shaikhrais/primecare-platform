import 'dart:async' show unawaited;
import 'package:flutter/material.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText,PrimeTextButton,PrimeTextField;
import '../shell_utilities/prime_shell_utilities.dart' show ShellUtilityLabels;
import 'application_shortcut_editor.dart';
/// Host supplies the existing registered labels and disposes its actor-bound editor on account change.
class PrimeApplicationShortcuts extends StatefulWidget {
 final ApplicationShortcutEditor editor;final ShellUtilityLabels labels;
 const PrimeApplicationShortcuts({super.key,required this.editor,required this.labels});
 @override State<PrimeApplicationShortcuts> createState()=>_PrimeApplicationShortcutsState();
}
class _PrimeApplicationShortcutsState extends State<PrimeApplicationShortcuts>{
 final search=TextEditingController();String query='';bool failed=false;int epoch=0;
 @override void initState(){super.initState();widget.editor.addListener(changed);}
 void changed(){if(mounted)setState((){});}
 @override void didUpdateWidget(covariant PrimeApplicationShortcuts old){super.didUpdateWidget(old);if(old.editor!=widget.editor){epoch++;old.editor.removeListener(changed);widget.editor.addListener(changed);query='';search.clear();failed=false;}}
 @override void dispose(){epoch++;widget.editor.removeListener(changed);search.dispose();super.dispose();}
 Future<void> run(Future<void> Function() action)async{final generation=epoch;try{if(failed)setState(()=>failed=false);await action();}catch(_){if(mounted&&generation==epoch)setState(()=>failed=true);}}
 Widget button(String key,Future<void> Function() action,bool disabled,{String suffix='',String? text,bool? selected}){final labels=widget.labels;return Semantics(identifier:labels.ids[key]!+suffix,label:text??labels(key),button:true,toggled:selected,child:PrimeTextButton(style:selected==true?PrimeTextButton.styleFrom(backgroundColor:Theme.of(context).colorScheme.primary,foregroundColor:Theme.of(context).colorScheme.onPrimary):null,onPressed:disabled?null:()=>unawaited(run(action)),child:PrimeText(text??labels(key))));}
 @override Widget build(BuildContext context){final editor=widget.editor,labels=widget.labels,state=editor.current,busy=['loading','saving','discarding'].contains(state['status']),blocked=busy||state['loaded']!=true,editable=!blocked&&['clean','dirty','offline'].contains(state['status']),ids=List<String>.from(state['selected'] as List);final status=failed?'error':state['status']=='clean'?'saved':busy?'loading':state['status'] as String;
 return Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[PrimeText(labels('favourites')),Semantics(identifier:labels.ids['search'],child:PrimeTextField(controller:search,maxLength:100,decoration:InputDecoration(labelText:labels('search')),onChanged:(value)=>setState(()=>query=value))),for(final destination in editor.destinations(query))button('favouriteToggle',()=>editor.toggle(destination.id),!editable||state['pending']!=null||state['remote']!=null,suffix:'-${destination.id}',text:destination.title,selected:ids.contains(destination.id)),Wrap(children:[button('refresh',editor.load,busy),button('save',editor.save,!editable||state['dirty']!=true||state['pending']!=null||state['remote']!=null),button('retry',editor.retryPending,blocked||state['pending']==null),button('acceptRemote',editor.acceptRemote,blocked||state['remote']==null),button('keepLocal',editor.keepLocal,blocked||state['remote']==null)]),Semantics(identifier:labels.ids['status'],liveRegion:true,child:PrimeText(labels(status)))]);
 }
}
