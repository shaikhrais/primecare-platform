import 'package:flutter/material.dart';
// ignore: unused_import

import 'package:primecare_ui/primecare_ui.dart';

class DocumentVaultScreen extends ConsumerWidget {
  const DocumentVaultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
    title: 'common.documentVault.title',
    subtitle: 'common.documentVault.subtitle',
    provider: commonFeatureDataProvider('document_vault'),
  );
}
