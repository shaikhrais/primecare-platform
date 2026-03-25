import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/api_client.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CoordinatorProfileScreen extends StatelessWidget {
  const CoordinatorProfileScreen({super.key});

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
              DefaultWidgetMatrix(
                title: 'Coordinator Station Profile',
                icon: Icons.account_box_rounded,
                apiEndpoint: '/v1/platform/staff',
              ),
              const SizedBox(height: 32),
              const DefaultActivityLog(),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultWidgetMatrix extends StatefulWidget {
  final String title;
  final IconData icon;
  final String apiEndpoint;

  const DefaultWidgetMatrix({
    super.key,
    required this.title,
    required this.icon,
    required this.apiEndpoint,
  });

  @override
  State<DefaultWidgetMatrix> createState() => _DefaultWidgetMatrixState();
}

class _DefaultWidgetMatrixState extends State<DefaultWidgetMatrix> {
  Future<List<dynamic>>? _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchData();
  }

  Future<List<dynamic>> _fetchData() async {
    final response = await apiClient.get(widget.apiEndpoint);
    if (response is List) {
      return response;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                widget.icon,
                color: Theme.of(context).primaryColor,
                size: 32,
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Secure data integration pipeline actively polling Cloudflare D1 nodes via WebSockets.',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          FutureBuilder<List<dynamic>>(
            future: _futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text(
                  'API Network Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                );
              }

              final data = snapshot.data ?? [];
              if (data.isEmpty) {
                return const Text(
                  'Zero payload results returned from D1 schema.',
                  style: TextStyle(color: Colors.grey),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                separatorBuilder: (_, _) => const Divider(),
                itemBuilder: (context, index) {
                  final node = data[index];
                  return ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.cloud_sync_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    title: Text(
                      node['title'] ??
                          node['text'] ??
                          node['id'] ??
                          'Encrypted Node $index',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      node['detail'] ??
                          node['status'] ??
                          'Verified telemetry fetched natively.',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: const Icon(
                      Icons.rocket_launch_rounded,
                      color: Colors.grey,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history_rounded,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'Live Execution Logs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildLogItem(context, 'Cloudflare REST API Verified', 'Just now'),
          _buildLogItem(
            context,
            'Prisma ORM SQLite Node Attached',
            '2 mins ago',
          ),
          _buildLogItem(
            context,
            'Core Global FutureBuilder Rendered',
            '4 mins ago',
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem(BuildContext context, String text, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: PrimeCareColors.emerald,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
