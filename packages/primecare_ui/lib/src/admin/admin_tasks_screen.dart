import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';
import '../screens/base_primecare_screen.dart';
import '../localization/app_localizations.dart';

/// Server task metadata and shared text catalog drive this inherited overview.
class AdminTasksScreen extends BasePrimecareScreen {
  final List<AdminTask> tasks;
  const AdminTasksScreen({super.key,required this.tasks});
  @override
  String get title => 'Admin tasks';
  @override
  String get titleKey => 'admin.tasks';
  @override
  Widget buildContent(BuildContext context) {
    final strings=AppStrings.of(context);
    if(tasks.any((task)=>!strings.containsKey(task.titleKey)||!strings.containsKey(task.descriptionKey)))return Center(child:Text(strings.text('error.invalidResponse')));
    return ListView(padding:const EdgeInsets.all(24),children:[
      Text(strings.text('admin.tasksIntro')),
      ...tasks.map((task)=>Card(child:Semantics(container:true,explicitChildNodes:true,child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(strings.text(task.titleKey),style:Theme.of(context).textTheme.titleMedium),
        const SizedBox(height:8),Text(strings.text(task.descriptionKey)),
      ]))))),
    ]);
  }
}
