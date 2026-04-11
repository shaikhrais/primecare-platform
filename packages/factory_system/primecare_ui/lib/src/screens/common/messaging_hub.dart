import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class MessagingHubScreen extends ConsumerWidget {
  const MessagingHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'common.messaging.title',
        subtitle: 'common.messaging.subtitle',
        provider: commonFeatureDataProvider('messaging'),
      );
}
