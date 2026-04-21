// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

class RootThemeProviderScreen extends ConsumerWidget {
  final dynamic data;
  
  const RootThemeProviderScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: 'rootThemeProvider',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.component, size: 64, color: context.theme.colors.primary),
            const SizedBox(height: 16),
            Text(
              'rootThemeProvider Implementation',
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('This component is part of the common_ui module.'),
          ],
        ),
      ),
    );
  }
}

