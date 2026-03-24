import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ManagerReportsScreen extends StatelessWidget {
  const ManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      body: DesktopPaneWrapper(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               const SizedBox(height: 16),
               DefaultWidgetMatrix(title: 'Data Analytics Reports', icon: Icons.bar_chart_rounded),
               const SizedBox(height: 32),
               const DefaultActivityLog(),
               const SizedBox(height: 64),
            ]
          )
        ),
      ),
    );
  }
}

class DefaultWidgetMatrix extends StatelessWidget {
  final String title;
  final IconData icon;

  const DefaultWidgetMatrix({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 8), spreadRadius: 2)]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).primaryColor, size: 32),
              const SizedBox(width: 16),
              Flexible(child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900))),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Secure data integration pipeline established. Real-time native synchronization logically connected to the API Node array natively.', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: Icon(Icons.dataset_linked_rounded, color: Theme.of(context).primaryColor)
                ),
                title: Text('Encrypted Database Entity ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                subtitle: const Text('Verified telemetry packet payload safely cached natively.'),
                trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
              );
            }
          )
        ]
      )
    );
  }
}

class DefaultActivityLog extends StatelessWidget {
  const DefaultActivityLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4), spreadRadius: 1)]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               Icon(Icons.history_rounded, color: Theme.of(context).primaryColor, size: 24),
               const SizedBox(width: 12),
               const Text('Recent System Operations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ]
          ),
          const SizedBox(height: 16),
          _buildLogItem(context, 'Synchronization Node Network Completed', 'Just now'),
          _buildLogItem(context, 'Cloudflare API Edge Firewall Validated', '2 mins ago'),
          _buildLogItem(context, 'Core Global Authentication Initialized', '1 hour ago'),
        ]
      )
    );
  }
  
  Widget _buildLogItem(BuildContext context, String text, String time) {
      return Padding(
         padding: const EdgeInsets.symmetric(vertical: 12),
         child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Row(children: [
                   Container(width: 8, height: 8, decoration: const BoxDecoration(color: PrimeCareColors.emerald, shape: BoxShape.circle)),
                   const SizedBox(width: 12),
                   Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
                ]),
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold))
            ]
         )
      );
  }
}
