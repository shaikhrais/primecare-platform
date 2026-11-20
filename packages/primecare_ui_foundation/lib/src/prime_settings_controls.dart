import 'package:flutter/material.dart';

/// Dense configurator controls retain the SDK's radio grouping and keyboard input.
class PrimeSettingsRadio<T> extends StatelessWidget {
  final T value;
  final Widget label;
  final VoidCallback onSelected;
  const PrimeSettingsRadio({super.key,required this.value,required this.label,required this.onSelected});
  @override Widget build(BuildContext context)=>MergeSemantics(child:InkWell(onTap:onSelected,canRequestFocus:false,
    child:SizedBox(height:32,child:Row(mainAxisSize:MainAxisSize.min,children:[
      SizedBox(width:21,child:Transform.translate(offset:const Offset(-5.5,0),child:Transform.scale(scale:.8,child:Radio<T>(value:value,materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,visualDensity:VisualDensity.compact)))),
      label,
    ]))));
}

/// A 28×16 visual track in a 44×32 interactive area, using the native SDK switch.
class PrimeSettingsSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;
  final FocusNode? focusNode;
  const PrimeSettingsSwitch({super.key,required this.value,required this.onChanged,required this.label,this.focusNode});
  @override Widget build(BuildContext context){final theme=Theme.of(context),color=theme.colorScheme.secondary;
    return Semantics(label:label,child:SizedBox(width:44,height:32,child:OverflowBox(alignment:AlignmentDirectional.centerStart,minWidth:52,maxWidth:52,minHeight:40,maxHeight:40,
      child:Transform.translate(offset:const Offset(-4,0),child:Transform.scale(scaleX:28/52,scaleY:.5,
        child:Switch(value:value,onChanged:onChanged,focusNode:focusNode,materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
          thumbIcon:WidgetStatePropertyAll(Icon(Icons.circle,size:0,color:theme.colorScheme.surface.withValues(alpha:0))),trackOutlineWidth:const WidgetStatePropertyAll(0),trackOutlineColor:WidgetStatePropertyAll(theme.colorScheme.surface.withValues(alpha:0)),
          thumbColor:WidgetStateProperty.resolveWith((states)=>states.contains(WidgetState.selected)?color:theme.colorScheme.surface),
          trackColor:WidgetStateProperty.resolveWith((states)=>states.contains(WidgetState.selected)?color.withValues(alpha:.5):theme.colorScheme.onSurface.withValues(alpha:.38))))))));
  }
}
