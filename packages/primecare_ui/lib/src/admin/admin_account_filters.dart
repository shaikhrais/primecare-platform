import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';

/// Shared presentation; inherited workflows own normalization and filter state.
class AdminAccountFilters extends StatelessWidget {
 final TextEditingController search;
 final bool busy;
 final String status;
 final int revision;
 final VoidCallback onSearch,onClear;
 final ValueChanged<String> onStatus;
 const AdminAccountFilters({super.key,required this.search,required this.busy,required this.status,required this.revision,required this.onSearch,required this.onClear,required this.onStatus});
 @override Widget build(BuildContext context){final strings=AppStrings.of(context);return Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
  TextField(controller:search,enabled:!busy,decoration:InputDecoration(labelText:strings.text('admin.searchLabel')),onSubmitted:(_)=>onSearch()),
  DropdownButtonFormField<String>(key:ValueKey((status,revision)),isExpanded:true,initialValue:status,decoration:InputDecoration(labelText:strings.text('admin.statusFilter')),items:['','active','inactive'].map((value)=>DropdownMenuItem(value:value,child:Text(strings.text(value.isEmpty?'admin.allStatuses':value)))).toList(),onChanged:busy?null:(value){if(value!=null)onStatus(value);}),
  Wrap(spacing:12,children:[FilledButton(onPressed:busy?null:onSearch,child:Text(strings.text('admin.searchApply'))),TextButton(onPressed:busy?null:onClear,child:Text(strings.text('admin.searchClear')))]),
 ]);}
}
