import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AppEmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const AppEmptyState({
    super.key,
    this.title = 'No Data Found',
    this.message = 'Try adjusting your filters or checking back later.',
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class AppErrorState extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;

  const AppErrorState({super.key, required this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text('Something went wrong', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(error.toString(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.redAccent)),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              GFButton(onPressed: onRetry, text: 'Retry'),
            ],
          ],
        ),
      ),
    );
  }
}

class NoAccessScreen extends StatelessWidget {
  const NoAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_person_outlined, size: 100, color: Colors.orange),
            const SizedBox(height: 24),
            Text('Access Restricted', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            const Text('You do not have the required permissions to view this screen.'),
            const SizedBox(height: 32),
            GFButton(
              onPressed: () => Navigator.of(context).pop(),
              text: 'Go Back',
              type: GFButtonType.outline,
            ),
          ],
        ),
      ),
    );
  }
}
