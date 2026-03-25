import '../../core/api_client.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class DailyTask {
  final String id;
  final String title;
  final String description;
  final String status;

  DailyTask({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  DailyTask copyWith({String? status}) {
    return DailyTask(
      id: id,
      title: title,
      description: description,
      status: status ?? this.status,
    );
  }
}

class UniversalTimelineScreen extends StatefulWidget {
  final String rolePrefix;

  const UniversalTimelineScreen({super.key, required this.rolePrefix});

  @override
  State<UniversalTimelineScreen> createState() =>
      _UniversalTimelineScreenState();
}

class _UniversalTimelineScreenState extends State<UniversalTimelineScreen> {
  bool _isLoading = true;
  List<DailyTask> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasksFromApi();
  }

  Future<void> _fetchTasksFromApi() async {
    String role = widget.rolePrefix.replaceAll('/', '');
    if (role.isEmpty) role = 'psw';
    if (role == 'admin') role = 'admin';
    if (role == 'scrum-master') role = 'scrum_master';

    try {
      final response = await apiClient.get('/v1/activities/$role');
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        List<DailyTask> dbTasks = jsonList
            .map(
              (j) => DailyTask(
                id: j['id'],
                title: j['title'],
                description: j['description'],
                status: j['status'],
              ),
            )
            .toList();

        if (mounted) {
          setState(() {
            _tasks = dbTasks;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _toggleTaskStatus(int index) async {
    final task = _tasks[index];
    final isCompleting = task.status == 'PENDING';
    final newStatus = isCompleting ? 'COMPLETED' : 'PENDING';

    // Optimistic UI Data store mutation
    setState(() {
      _tasks[index] = task.copyWith(status: newStatus);
    });

    try {
      final response = await apiClient.patch('/v1/activities/\${task.id}', {
        'status': newStatus,
      });

      if (response.statusCode == 200) {
        if (mounted && isCompleting) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.cloud_done, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Edge Matrix Updated: Row synced to Prisma.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              backgroundColor: Color(0xFF059669),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        throw Exception('API Failure');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _tasks[index] = task.copyWith(
            status: isCompleting ? 'PENDING' : 'COMPLETED',
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;

    return PrimeCareScaffold(
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    'Fetching PostgreSQL Tracking Array via API...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timeline_rounded, size: 48, color: primary),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Daily Activity Timeline',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'DB -> API -> UI Execution Tracker for [${widget.rolePrefix.toUpperCase()}]',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildPersonalTelemetry(primary),
                  const SizedBox(height: 32),
                  PrimeCareCard(
                    padding: EdgeInsets.zero,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _tasks.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        final isDone = task.status == 'COMPLETED';

                        return InkWell(
                          onTap: () => _toggleTaskStatus(index),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isDone
                                        ? Color(0xFF10B981)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isDone
                                          ? Color(0xFF10B981)
                                          : Colors.grey[400]!,
                                      width: 2,
                                    ),
                                  ),
                                  child: isDone
                                      ? Icon(
                                          Icons.check,
                                          size: 20,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task.title,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          decoration: isDone
                                              ? TextDecoration.lineThrough
                                              : null,
                                          color: isDone
                                              ? Colors.grey[500]
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        task.description,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isDone
                                              ? Colors.grey[400]
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isDone) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(
                                        0xFF10B981,
                                      ).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'DB SYNCED',
                                      style: TextStyle(
                                        color: Color(0xFF10B981),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ] else ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'API PENDING',
                                      style: TextStyle(
                                        color: Colors.orange[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildPersonalTelemetry(Color primary) {
    int total = _tasks.length;
    int done = _tasks.where((t) => t.status == 'COMPLETED').length;
    double score = total == 0 ? 0 : (done / total);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primary.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.query_stats, color: primary),
              const SizedBox(width: 8),
              Text(
                'My Personal Work Telemetry',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: PrimeCareColors.radarDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            children: [
              _buildStatBox(
                'Time on System Today',
                '5h 12m',
                Icons.timer_outlined,
                Colors.purple,
              ),
              _buildStatBox(
                'Database Rows Synced',
                '\$done / \$total',
                Icons.storage_rounded,
                Colors.blue,
              ),
              _buildStatBox(
                'Operational Efficiency',
                '\${(score * 100).toInt()}%',
                Icons.health_and_safety,
                score >= 0.8 ? Colors.green : Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon, Color color) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
