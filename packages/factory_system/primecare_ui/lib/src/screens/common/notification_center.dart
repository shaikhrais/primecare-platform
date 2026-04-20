import 'package:flutter/material.dart';
// ignore: unused_import

import 'package:primecare_ui/primecare_ui.dart';

class NotificationCenterScreen extends ConsumerWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
    title: 'common.notifications.title',
    subtitle: 'common.notifications.subtitle',
    provider: commonFeatureDataProvider('notifications'),
  );
}
