// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

class NavbarLayout2Screen extends ConsumerWidget {
  final dynamic data;
  
  const NavbarLayout2Screen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: 'navbarLayout2',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.component, size: 64, color: context.theme.colors.primary),
            const SizedBox(height: 16),
            Text(
              'navbarLayout2 Implementation',
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('This component is part of the shared/layouts module.'),
          ],
        ),
      ),
    );
  }
}

