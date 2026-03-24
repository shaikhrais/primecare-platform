const fs = require('fs');
const path = require('path');

const timelinePath = path.join(__dirname, '..', 'lib', 'features', 'shared', 'universal_timeline_screen.dart');
let code = fs.readFileSync(timelinePath, 'utf8');

if (!code.includes("import '../../core/api_client.dart';")) {
  code = "import '../../core/api_client.dart';\nimport 'dart:convert';\n" + code;
}

const oldFetchBlock = /Future<void> _fetchTasksFromApi\(\) async {[\s\S]*?_isLoading = false;\n\s*}\n\s*}\n\s*}/;
const newFetchBlock = `Future<void> _fetchTasksFromApi() async {
    String role = widget.rolePrefix.replaceAll('/', '');
    if (role.isEmpty) role = 'psw';
    if (role == 'dashboard') role = 'admin';
    if (role == 'scrum-master') role = 'scrum_master';

    try {
      final response = await apiClient.get('/v1/activities/$role');
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        List<DailyTask> dbTasks = jsonList.map((j) => DailyTask(
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
      } else {
        throw Exception('API Error');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }`;

code = code.replace(oldFetchBlock, newFetchBlock);

const oldToggleBlock = /Future<void> _toggleTaskStatus\(int index\) async {[\s\S]*?_tasks\[index\] = task\.copyWith\(status: isCompleting \? 'PENDING' : 'COMPLETED'\);\n\s*}\n\s*}\n\s*}/;
const newToggleBlock = `Future<void> _toggleTaskStatus(int index) async {
    final task = _tasks[index];
    final isCompleting = task.status == 'PENDING';
    final newStatus = isCompleting ? 'COMPLETED' : 'PENDING';
    
    // Optimistic UI mutation
    setState(() {
      _tasks[index] = task.copyWith(status: newStatus);
    });

    try {
      final response = await apiClient.patch('/v1/activities/\${task.id}', body: { 'status': newStatus });
      
      if (response.statusCode == 200) {
        if (mounted && isCompleting) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.cloud_done, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text('Edge Matrix Updated: Row synced to Prisma.', style: TextStyle(fontWeight: FontWeight.bold)),
                ]
              ), 
              backgroundColor: Color(0xFF059669),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            )
          );
        }
      } else {
        throw Exception('API Failure');
      }
    } catch (e) {
      // Rollback on failure
      if (mounted) {
        setState(() {
          _tasks[index] = task.copyWith(status: isCompleting ? 'PENDING' : 'COMPLETED');
        });
      }
    }
  }`;

code = code.replace(oldToggleBlock, newToggleBlock);

fs.writeFileSync(timelinePath, code);
console.log("Universal Timeline securely bound to Edge Worker API!");
