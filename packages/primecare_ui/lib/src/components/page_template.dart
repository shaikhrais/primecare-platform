import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Color>? headerGradientColors;
  final List<Widget>? kpiCards;
  final List<Widget>? children;
  final Widget? child;
  final Widget? actionButton;
  
  const PageTemplate({
    super.key, 
    required this.title, 
    this.subtitle,
    this.icon,
    this.headerGradientColors,
    this.kpiCards,
    this.children,
    this.child,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actionButton != null ? [actionButton!] : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subtitle != null) Text(subtitle!, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            if (kpiCards != null) ...[
              const SizedBox(height: 16),
              Row(children: kpiCards!.map((c) => Expanded(child: c)).toList()),
            ],
            const SizedBox(height: 16),
            if (child != null) child!,
            if (children != null) ...children!,
          ],
        ),
      ),
    );
  }
}
