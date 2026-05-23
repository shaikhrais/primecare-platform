// Governance - Category: view | Purpose: [GovernanceEventFeed] - A high-fidelity real-time telemetry feed showing architectural and security events as they ha...
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/governance/governance_provider.dart';

/// [GovernanceEventFeed] - A high-fidelity real-time telemetry feed
/// showing architectural and security events as they happen.
class GovernanceEventFeed extends StatelessWidget {
  final List<GovernanceEvent> events;

  const GovernanceEventFeed({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.bolt_rounded, color: Colors.amber, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Live Telemetry Feed',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Live',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (events.isEmpty)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sensors_off_rounded,
                      color: Colors.grey,
                      size: 48,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No events detected yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemCount: events.length,
                separatorBuilder: (context, index) => const Divider(height: 24),
                itemBuilder: (context, index) {
                  final event = events[index];
                  return _EventItem(event: event);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final GovernanceEvent event;

  const _EventItem({required this.event});

  @override
  Widget build(BuildContext context) {
    final color = _getEventColor(event.level);
    final icon = _getEventIcon(event.type);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.type.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: color,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm:ss').format(event.timestamp),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                event.message,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getEventColor(GovernanceEventLevel level) {
    switch (level) {
      case GovernanceEventLevel.critical:
      case GovernanceEventLevel.error:
        return Colors.red;
      case GovernanceEventLevel.warning:
        return Colors.amber;
      case GovernanceEventLevel.success:
        return Colors.green;
      case GovernanceEventLevel.info:
      case GovernanceEventLevel.all:
        return Colors.blue;
    }
  }

  IconData _getEventIcon(String type) {
    switch (type.toLowerCase()) {
      case 'security':
        return Icons.security_rounded;
      case 'audit':
        return Icons.analytics_rounded;
      case 'performance':
        return Icons.speed_rounded;
      case 'deployment':
        return Icons.cloud_upload_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }
}
