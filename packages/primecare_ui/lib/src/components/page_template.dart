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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subtitle != null) 
                  Text(subtitle!, overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                if (kpiCards != null) ...[
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      int crossAxisCount;
                      if (width > 1000) {
                        crossAxisCount = 4;
                      } else if (width > 600) {
                        crossAxisCount = 2;
                      } else {
                        crossAxisCount = 1;
                      }
                      
                      final double spacing = 16.0;
                      final double itemWidth = (width - (spacing * (crossAxisCount - 1))) / crossAxisCount;
                      
                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: kpiCards!.map((c) => SizedBox(width: itemWidth, child: c)).toList(),
                      );
                    },
                  ),
                ],
                const SizedBox(height: 16),
                ?child,
                if (children != null) ...children!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
