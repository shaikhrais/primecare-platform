import 'dart:io';
import 'dart:convert';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final jsonFile = File('artifacts/all_screens_data.json');
  if (!jsonFile.existsSync()) {
    print('Error: all_screens_data.json not found.');
    return;
  }

  final List<dynamic> screensData =
      jsonDecode(jsonFile.readAsStringSync()) as List<dynamic>;
  final screens = screensData.cast<Map<String, dynamic>>();

  // Fetch Application Screen Distribution from SQLite
  final List<Map<String, dynamic>> appDistribution = [];
  try {
    final db = sqlite3.open('.agents/governance/governance.db');
    final ResultSet results = db.select('''
      SELECT a.app_code, a.app_name, COUNT(s.id) as screen_count
      FROM apps a
      LEFT JOIN screens s ON a.id = s.app_id
      GROUP BY a.id
      ORDER BY screen_count DESC, a.app_code;
    ''');
    
    for (final row in results) {
      appDistribution.add({
        'app_code': row['app_code'],
        'app_name': row['app_name'],
        'screen_count': row['screen_count'] as int,
      });
    }
    db.dispose();
  } catch (e) {
    print('Warning: could not fetch screen distribution from SQLite: $e');
  }

  // Calculate max screens for progress bar normalization
  int maxScreens = 1;
  for (final app in appDistribution) {
    final count = app['screen_count'] as int;
    if (count > maxScreens) {
      maxScreens = count;
    }
  }

  final buffer = StringBuffer();
  buffer.writeln('''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PrimeCare Platform - Screen Registry Audit</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.7);
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --accent-primary: #38bdf8;
            --accent-secondary: #818cf8;
            --status-completed: #22c55e;
            --status-backlog: #f59e0b;
            --border-color: rgba(255, 255, 255, 0.1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-color); color: var(--text-primary); line-height: 1.6; padding: 2rem; }
        .header { max-width: 1200px; margin: 0 auto 3rem auto; text-align: center; }
        h1 { font-size: 2.5rem; font-weight: 700; background: linear-gradient(to right, var(--accent-primary), var(--accent-secondary)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 0.5rem; }
        .subtitle { color: var(--text-secondary); font-size: 1.1rem; }
        .stats-container { display: flex; gap: 1.5rem; justify-content: center; margin-bottom: 3rem; }
        .stat-card { background: var(--card-bg); backdrop-filter: blur(10px); padding: 1.5rem 2rem; border-radius: 1rem; border: 1px solid var(--border-color); text-align: center; min-width: 150px; }
        .stat-value { font-size: 2rem; font-weight: 700; display: block; }
        .stat-label { color: var(--text-secondary); font-size: 0.875rem; text-transform: uppercase; letter-spacing: 0.05em; }
        
        /* Application Screen Distribution Styling */
        .distribution-container {
            max-width: 1200px;
            margin: 0 auto 3rem auto;
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            padding: 2.5rem;
            border-radius: 1rem;
            border: 1px solid var(--border-color);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }
        .distribution-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            background: linear-gradient(to right, var(--accent-primary), var(--accent-secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 0.75rem;
        }
        .distribution-grid {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
        }
        .distribution-row {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        .app-info {
            width: 280px;
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-primary);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .app-code {
            color: var(--accent-primary);
            font-family: 'Courier New', monospace;
            font-weight: 700;
            background: rgba(56, 189, 248, 0.1);
            padding: 0.2rem 0.5rem;
            border-radius: 0.375rem;
            margin-right: 0.5rem;
            border: 1px solid rgba(56, 189, 248, 0.2);
        }
        .bar-wrapper {
            flex: 1;
            background: rgba(255, 255, 255, 0.03);
            height: 14px;
            border-radius: 9999px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            position: relative;
        }
        .bar-fill {
            height: 100%;
            border-radius: 9999px;
            background: linear-gradient(to right, var(--accent-primary), var(--accent-secondary));
            box-shadow: 0 0 10px rgba(56, 189, 248, 0.3);
            position: relative;
        }
        .screen-count-badge {
            width: 120px;
            text-align: right;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-secondary);
        }
        .screen-count-val {
            color: var(--accent-primary);
            font-size: 1.05rem;
            font-weight: 700;
        }

        .table-container { max-width: 1200px; margin: 0 auto; background: var(--card-bg); backdrop-filter: blur(10px); border-radius: 1rem; border: 1px solid var(--border-color); overflow: hidden; box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5); }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { background: rgba(255, 255, 255, 0.05); padding: 1rem 1.5rem; font-size: 0.875rem; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); border-bottom: 1px solid var(--border-color); }
        td { padding: 1rem 1.5rem; border-bottom: 1px solid var(--border-color); font-size: 0.9375rem; }
        tr:hover { background: rgba(255, 255, 255, 0.02); }
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 9999px; font-size: 0.75rem; font-weight: 600; text-transform: capitalize; }
        .status-completed { background: rgba(34, 197, 94, 0.1); color: var(--status-completed); border: 1px solid rgba(34, 197, 94, 0.2); }
        .status-backlog { background: rgba(245, 158, 11, 0.1); color: var(--status-backlog); border: 1px solid rgba(245, 158, 11, 0.2); }
        .comp-count { display: inline-flex; align-items: center; justify-content: center; background: rgba(255, 255, 255, 0.1); border-radius: 0.5rem; width: 2rem; height: 2rem; font-weight: 600; }
        .id-cell { font-family: 'Courier New', monospace; font-size: 0.8rem; color: var(--accent-primary); }
        .office-cell { font-weight: 600; }
    </style>
</head>
<body>
    <div class="header">
        <h1>PrimeCare Registry Audit</h1>
        <p class="subtitle">Platform Governance & Architectural Parity Monitoring</p>
    </div>

    <div class="stats-container">
        <div class="stat-card">
            <span class="stat-value">${screens.length}</span>
            <span class="stat-label">Total Screens</span>
        </div>
        <div class="stat-card">
            <span class="stat-value">${screens.where((s) => s['lifecycle'] == 'completed').length}</span>
            <span class="stat-label">Completed</span>
        </div>
        <div class="stat-card">
            <span class="stat-value">${screens.where((s) => s['lifecycle'] != 'completed').length}</span>
            <span class="stat-label">Backlog</span>
        </div>
    </div>
''');

  if (appDistribution.isNotEmpty) {
    buffer.writeln('''
    <div class="distribution-container">
        <h2 class="distribution-title">Application Screen Distribution</h2>
        <div class="distribution-grid">
    ''');
    
    for (final app in appDistribution) {
      final code = app['app_code'];
      final name = app['app_name'];
      final count = app['screen_count'] as int;
      final double percent = maxScreens > 0 ? (count / maxScreens) * 100 : 0;
      
      buffer.writeln('''
            <div class="distribution-row">
                <div class="app-info">
                    <span class="app-code">${code}</span>
                    <span>${name}</span>
                </div>
                <div class="bar-wrapper">
                    <div class="bar-fill" style="width: ${percent.toStringAsFixed(1)}%;"></div>
                </div>
                <div class="screen-count-badge">
                    <span class="screen-count-val">${count}</span> screens
                </div>
            </div>
      ''');
    }
    
    buffer.writeln('''
        </div>
    </div>
    ''');
  }

  buffer.writeln('''
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Office</th>
                    <th>Title / ID</th>
                    <th>Status</th>
                    <th>Components</th>
                    <th>Registry Path</th>
                </tr>
            </thead>
            <tbody>
''');

  for (final screen in screens) {
    final statusClass = screen['lifecycle'] == 'completed'
        ? 'status-completed'
        : 'status-backlog';
    buffer.writeln('''
                <tr>
                    <td><span class="office-cell">\${screen['office']}</span></td>
                    <td>
                        <div style="font-weight: 600;">\${screen['title']}</div>
                        <div class="id-cell">\${screen['id']}</div>
                    </td>
                    <td><span class="status-badge \$statusClass">\${screen['lifecycle']}</span></td>
                    <td style="text-align: center;"><span class="comp-count">\${screen['components']}</span></td>
                    <td style="font-size: 0.75rem; color: var(--text-secondary);">\${screen['path']}</td>
                </tr>
''');
  }

  buffer.writeln('''
            </tbody>
        </table>
    </div>
</body>
</html>
''');

  File('artifacts/all_screens_audit.html').writeAsStringSync(buffer.toString());
  print('Successfully generated artifacts/all_screens_audit.html');
}
