import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PartnershipManagerOutreachScreen extends ConsumerWidget {
  const PartnershipManagerOutreachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: PrimeAppBar(
        title: '${m[1]}artnership ${m[1]}anager ${m[1]}utreach',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the ${m[1]}artnership ${m[1]}anager ${m[1]}utreach',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              SizedBox(height: theme.spacing.md),
              Text(
                'This screen was generated natively using PrimeCare design system.',
                style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              SizedBox(height: theme.spacing.xl),
              Expanded(
                child: Center(
                  child: EmptyState(
                    title: 'No Data Available',
                    description: 'The backend hydration for this feature is currently pending.',
                    icon: Icons.data_usage,
                    primaryActionLabel: 'Refresh',
                    onPrimaryAction: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
