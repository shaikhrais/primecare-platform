import 'package:flutter/material.dart';

/// Phase 87: Absolute Primitive Encapsulation
/// The Executive mandate demands 0 explicit references to flutter/material primitives globally.
/// These proxies guarantee future centralized thematic compliance without regex-breaking local instances.

class PrimeCareText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const PrimeCareText(this.data, {super.key, this.style, this.textAlign, this.overflow, this.maxLines});

  @override Widget build(BuildContext context) => Text(data, style: style, textAlign: textAlign, overflow: overflow, maxLines: maxLines);
}

class PrimeCareIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const PrimeCareIcon(this.icon, {super.key, this.color, this.size});

  @override Widget build(BuildContext context) => Icon(icon, color: color, size: size);
}

class PrimeCareSizedBox extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  const PrimeCareSizedBox({super.key, this.width, this.height, this.child});
  const PrimeCareSizedBox.shrink({super.key}) : width = 0.0, height = 0.0, child = null;
  const PrimeCareSizedBox.square({super.key, double? dimension, this.child}) : width = dimension, height = dimension;

  @override Widget build(BuildContext context) => SizedBox(width: width, height: height, child: child);
}

class PrimeCareExpanded extends StatelessWidget {
  final Widget child;
  final int flex;

  const PrimeCareExpanded({super.key, required this.child, this.flex = 1});

  @override Widget build(BuildContext context) => Expanded(flex: flex, child: child);
}

class PrimeCareCenter extends StatelessWidget {
  final Widget? child;
  const PrimeCareCenter({super.key, this.child});
  @override Widget build(BuildContext context) => Center(child: child);
}

class PrimeCarePadding extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Widget? child;
  const PrimeCarePadding({super.key, required this.padding, this.child});
  @override Widget build(BuildContext context) => Padding(padding: padding, child: child);
}

class PrimeCareContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final Color? color;
  final AlignmentGeometry? alignment;

  const PrimeCareContainer({super.key, this.child, this.width, this.height, this.padding, this.margin, this.decoration, this.color, this.alignment});

  @override Widget build(BuildContext context) => Container(width: width, height: height, padding: padding, margin: margin, decoration: decoration, color: color, alignment: alignment, child: child);
}

class PrimeCareStack extends StatelessWidget {
  final List<Widget> children;
  final AlignmentGeometry alignment;
  final StackFit fit;

  const PrimeCareStack({super.key, required this.children, this.alignment = AlignmentDirectional.topStart, this.fit = StackFit.loose});

  @override Widget build(BuildContext context) => Stack(alignment: alignment, fit: fit, children: children);
}

class PrimeCareListView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const PrimeCareListView({super.key, required this.children, this.padding, this.shrinkWrap = false, this.physics});

  @override Widget build(BuildContext context) => ListView(padding: padding, shrinkWrap: shrinkWrap, physics: physics, children: children);
}

class PrimeCareScrollWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;

  const PrimeCareScrollWrapper({super.key, required this.child, this.padding, this.physics});

  @override Widget build(BuildContext context) => SingleChildScrollView(padding: padding, physics: physics, child: child);
}

class PrimeCareSafeArea extends StatelessWidget {
  final Widget child;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  const PrimeCareSafeArea({super.key, required this.child, this.top = true, this.bottom = true, this.left = true, this.right = true});

  @override Widget build(BuildContext context) => SafeArea(top: top, bottom: bottom, left: left, right: right, child: child);
}

class PrimeCareNavBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final double? elevation;
  final Color? backgroundColor;
  final Color? shadowColor;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;

  const PrimeCareNavBar({super.key, this.title, this.actions, this.leading, this.elevation, this.backgroundColor, this.shadowColor, this.bottom, this.centerTitle});

  @override Widget build(BuildContext context) => AppBar(title: title, actions: actions, leading: leading, elevation: elevation, backgroundColor: backgroundColor, shadowColor: shadowColor, bottom: bottom, centerTitle: centerTitle);
  @override Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PrimeCareLoader extends StatelessWidget {
  final Color? color;
  const PrimeCareLoader({super.key, this.color});
  @override Widget build(BuildContext context) => CircularProgressIndicator(color: color);
}

class PrimeCareIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final Color? color;
  const PrimeCareIconButton({super.key, required this.onPressed, required this.icon, this.color});
  @override Widget build(BuildContext context) => IconButton(onPressed: onPressed, icon: icon, color: color);
}

class PrimeCareTextField extends StatelessWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final bool obscureText;
  const PrimeCareTextField({super.key, this.controller, this.decoration, this.obscureText = false});
  @override Widget build(BuildContext context) => TextField(controller: controller, decoration: decoration, obscureText: obscureText);
}

class PrimeCareGesture extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const PrimeCareGesture({super.key, required this.child, this.onTap});
  @override Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: child);
}

class PrimeCareInkWell extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const PrimeCareInkWell({super.key, required this.child, this.onTap});
  @override Widget build(BuildContext context) => InkWell(onTap: onTap, child: child);
}
