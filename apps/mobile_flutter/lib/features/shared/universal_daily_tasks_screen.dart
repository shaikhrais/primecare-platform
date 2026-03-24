import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../core/api_client.dart';

class DailyTaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  
  DailyTaskModel({required this.id, required this.title, required this.description, required this.status});
  
  DailyTaskModel copyWith({String? status}) {
    return DailyTaskModel(id: id, title: title, description: description, status: status ?? this.status);
  }
}

class UniversalDailyTasksScreen extends StatefulWidget {
  final String rolePrefix;

  const UniversalDailyTasksScreen({super.key, required this.rolePrefix});

  @override
  State<UniversalDailyTasksScreen> createState() => _UniversalDailyTasksScreenState();
}

class _UniversalDailyTasksScreenState extends State<UniversalDailyTasksScreen> {
  bool _isLoading = true;
  List<DailyTaskModel> _tasks = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTasksFromApi();
  }

  Future<void> _fetchTasksFromApi() async {
    String role = widget.rolePrefix.replaceAll('/', '');
    if (role.isEmpty) role = 'psw';
    if (role == 'dashboard') role = 'admin';
    if (role == 'scrum-master') role = 'scrum_master';

    try {
      final response = await apiClient.get('/v1/activities/$role');
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        List<DailyTaskModel> dbTasks = jsonList.map((j) => DailyTaskModel(
          id: j['id'],
          title: j['title'],
          description: j['description'],
          status: j['status']
        )).toList();
        
        if (mounted) {
          setState(() {
            _tasks = dbTasks;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) { setState(() { _isLoading = false; }); }
    }
  }

  Future<void> _createDataEntryTask() async {
    if (_titleController.text.isEmpty) return;
    
    String role = widget.rolePrefix.replaceAll('/', '');
    if (role == 'scrum-master') role = 'scrum_master';
    if (role == 'dashboard') role = 'admin';

    try {
      final response = await apiClient.post('/v1/activities', {
        'title': _titleController.text,
        'description': _descController.text,
        'role': role
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (mounted) {
          setState(() {
            _tasks.insert(0, DailyTaskModel(
              id: jsonResponse['id'],
              title: jsonResponse['title'],
              description: jsonResponse['description'],
              status: jsonResponse['status']
            ));
          });
          Navigator.pop(context); // Close Modal
          _titleController.clear();
          _descController.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New Data Entry Task securely saved to Database!'), backgroundColor: Colors.green));
        }
      }
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edge API Failure...'), backgroundColor: Colors.red));
    }
  }

  Future<void> _toggleTaskStatus(int index) async {
    final task = _tasks[index];
    final isCompleting = task.status == 'PENDING';
    final newStatus = isCompleting ? 'COMPLETED' : 'PENDING';
    
    setState(() { _tasks[index] = task.copyWith(status: newStatus); });

    try {
      final response = await apiClient.patch('/v1/activities/${task.id}', { 'status': newStatus });
      if (response.statusCode != 200) throw Exception('API Failure');
    } catch (e) {
      if (mounted) setState(() { _tasks[index] = task.copyWith(status: isCompleting ? 'PENDING' : 'COMPLETED'); });
    }
  }

  void _showDataEntryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 24, right: 24, top: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.edit_document, size: 36, color: Theme.of(context).primaryColor),
                const SizedBox(width: 16),
                const Text('Generate Data Entry Node', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Data Execution Target Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Operational Instructions (Form Data Variables)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _createDataEntryTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              child: const Text('Execute Cloudflare Database Post', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 32),
          ]
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    
    return PrimeCareScaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showDataEntryModal(context),
        backgroundColor: primary,
        icon: const Icon(Icons.add_task, color: Colors.white),
        label: const Text('Create Data Entry Config', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.format_list_bulleted_add, size: 48, color: primary),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Operational Data Form Entry: ${widget.rolePrefix.toUpperCase()}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
                        Text('Dynamically ingest, define, and execute physical database workflows natively.', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 32),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    final isDone = task.status == 'COMPLETED';
                    
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDone ? Colors.green.withValues(alpha:0.3) : Colors.grey.withValues(alpha: 0.2)),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    task.title, 
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, decoration: isDone ? TextDecoration.lineThrough : null, color: isDone ? Colors.grey[500] : PrimeCareColors.radarDark)
                                  )
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(color: isDone ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                                  child: Text(isDone ? 'OPERATION RESOLVED' : 'PENDING SYNC', style: TextStyle(color: isDone ? Colors.green[700] : Colors.orange[700], fontWeight: FontWeight.bold, fontSize: 12)),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(task.description, style: TextStyle(fontSize: 15, color: isDone ? Colors.grey[400] : Colors.grey[600])),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: isDone ? null : () {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Initializing Native Master Execution Forms...'), backgroundColor: Colors.blue));
                                    },
                                    icon: const Icon(Icons.arrow_forward, color: Colors.blue),
                                    label: const Text('Execute Data Form Engine', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.withValues(alpha:0.1), elevation: 0),
                                  )
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton.icon(
                                  onPressed: () => _toggleTaskStatus(index),
                                  icon: Icon(isDone ? Icons.undo : Icons.check_circle, color: isDone ? Colors.grey : Colors.green),
                                  label: Text(isDone ? 'Revert Node' : 'Resolve Tracking', style: TextStyle(color: isDone ? Colors.grey : Colors.green, fontWeight: FontWeight.bold)),
                                  style: ElevatedButton.styleFrom(backgroundColor: isDone ? Colors.grey.withValues(alpha:0.1) : Colors.green.withValues(alpha:0.1), elevation: 0),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          )
    );
  }
}
