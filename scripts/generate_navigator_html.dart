import 'dart:io';
import 'dart:convert';

void main() {
  final jsonFile = File('artifacts/all_screens_data.json');
  if (!jsonFile.existsSync()) {
    print('Error: all_screens_data.json not found.');
    return;
  }

  final List<dynamic> screensData =
      jsonDecode(jsonFile.readAsStringSync()) as List<dynamic>;
  final screens = screensData.cast<Map<String, dynamic>>();
  final screensJson = jsonEncode(screens);

  final buffer = StringBuffer();
  buffer.writeln('''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PrimeCare Governance Navigator</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --glass-bg: rgba(15, 23, 42, 0.8);
            --accent: #6366f1;
            --text: #f1f5f9;
        }
        body { margin: 0; font-family: 'Outfit', sans-serif; background: #020617; color: var(--text); overflow-hidden; height: 100vh; display: flex; }
        .sidebar { width: 400px; height: 100vh; background: var(--glass-bg); border-right: 1px solid rgba(255,255,255,0.1); display: flex; flex-direction: column; overflow-hidden; }
        .sidebar-header { padding: 2rem; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .search-box { width: 100%; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); padding: 0.75rem 1rem; border-radius: 0.5rem; color: white; margin-top: 1rem; outline: none; }
        .screen-list { flex: 1; overflow-y: auto; padding: 1rem; }
        .screen-item { padding: 1rem; border-radius: 0.5rem; cursor: pointer; border-bottom: 1px solid rgba(255,255,255,0.05); transition: all 0.2s; }
        .screen-item:hover { background: rgba(255,255,255,0.05); }
        .screen-item.active { background: var(--accent); }
        .main-content { flex: 1; display: flex; flex-direction: column; padding: 2rem; overflow-y: auto; }
        .badge { font-size: 0.7rem; padding: 0.2rem 0.5rem; border-radius: 4px; background: rgba(255,255,255,0.1); text-transform: uppercase; }
        .office-tag { color: var(--accent); font-weight: 700; font-size: 0.8rem; }
        .metadata-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 2rem; margin-top: 2rem; }
        .metadata-card { background: rgba(255,255,255,0.03); padding: 2rem; border-radius: 1rem; border: 1px solid rgba(255,255,255,0.1); }
        .placeholder { display: flex; align-items: center; justify-content: center; height: 100%; color: #475569; font-size: 1.5rem; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>Registry Navigator</h2>
            <input type="text" class="search-box" placeholder="Search 308 screens..." id="search">
        </div>
        <div class="screen-list" id="list"></div>
    </div>
    <div class="main-content" id="viewer">
        <div class="placeholder">Select a screen to view registry details</div>
    </div>

    <script>
        const screens = $screensJson;
        const list = document.getElementById('list');
        const viewer = document.getElementById('viewer');
        const search = document.getElementById('search');

        function renderList(filter = '') {
            list.innerHTML = '';
            screens.filter(s => s.title.toLowerCase().includes(filter.toLowerCase()) || s.id.toLowerCase().includes(filter.toLowerCase()))
                   .forEach(s => {
                const div = document.createElement('div');
                div.className = 'screen-item';
                div.innerHTML = `
                    <div class="office-tag">\${s.office}</div>
                    <div style="font-weight: 600;">\${s.title}</div>
                    <div class="badge">\${s.lifecycle}</div>
                `;
                div.onclick = () => selectScreen(s, div);
                list.appendChild(div);
            });
        }

        function selectScreen(s, el) {
            document.querySelectorAll('.screen-item').forEach(i => i.classList.remove('active'));
            el.classList.add('active');
            viewer.innerHTML = `
                <div style="margin-bottom: 2rem;">
                    <div class="office-tag" style="font-size: 1.2rem;">\${s.office}</div>
                    <h1 style="font-size: 3rem; margin: 0.5rem 0;">\${s.title}</h1>
                    <code style="background: #1e293b; padding: 0.5rem 1rem; border-radius: 0.5rem; color: #38bdf8;">\${s.id}</code>
                </div>
                <div class="metadata-grid">
                    <div class="metadata-card">
                        <h3>Governance Status</h3>
                        <div style="font-size: 2rem; color: \${s.lifecycle === 'completed' ? '#22c55e' : '#f59e0b'};">\${s.lifecycle.toUpperCase()}</div>
                    </div>
                    <div class="metadata-card">
                        <h3>Registered Components</h3>
                        <div style="font-size: 2rem;">\${s.components}</div>
                    </div>
                </div>
                <div class="metadata-card" style="margin-top: 2rem;">
                    <h3>Source Registry File</h3>
                    <div style="font-family: monospace; opacity: 0.7; margin-top: 1rem;">\${s.path}</div>
                </div>
            `;
        }

        search.oninput = (e) => renderList(e.target.value);
        renderList();
    </script>
</body>
</html>
''');

  File(
    'artifacts/primecare_navigator.html',
  ).writeAsStringSync(buffer.toString());
  print('Successfully generated artifacts/primecare_navigator.html');
}
