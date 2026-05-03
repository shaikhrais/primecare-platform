import os
import glob
import re

APPS_DIR = 'apps'

def fix_app_router(path):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    if "import 'package:primecare_ui/src/routes/shared_routes.dart';" not in content:
        content = content.replace("import 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart';\nimport 'package:primecare_ui/src/routes/shared_routes.dart';\nimport 'package:primecare_ui/src/screens/common/shared_screen_stubs.dart';")
    
    content = content.replace('NotFoundScreen(message: state.error?.message)', 'CommonUiError404PageViewScreen()')
    content = content.replace('const LoginScreen()', 'const SignInView()')
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

def fix_main(path):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    if "import 'package:primecare_ui/primecare_ui.dart';" not in content:
        content = content.replace("import 'package:flutter_core/primecare_core.dart';", "import 'package:primecare_ui/primecare_ui.dart';")
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

def fix_model(path):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    content = content.replace("metrics: DashboardMetrics.fromJson(json['metrics']),", "metrics: DashboardMetrics.fromJson(json['metrics'] as Map<String, dynamic>),")
    content = content.replace(".map((i) => IntelligenceInsight.fromJson(i))", ".map((i) => IntelligenceInsight.fromJson(i as Map<String, dynamic>))")
    content = content.replace("isOfflineFallback: json['isOfflineFallback'] ?? false,", "isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,")
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

def fix_view(path):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Remove flutter/material.dart if primecare_ui is there
    if "import 'package:primecare_ui/primecare_ui.dart';" in content:
        content = content.replace("import 'package:flutter/material.dart';\n", "")
    
    # Also remove duplicate primecare_ui imports
    content = content.replace("import 'package:primecare_ui/primecare_ui.dart';\nimport 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart';")
    
    # Fix ErrorStateView -> DashboardErrorWidget
    content = re.sub(r'ErrorStateView\(error:\s*([^\)]+)\)', r'DashboardErrorWidget(message: \1, onRetry: () {})', content)
    
    # Fix LoadingStateView -> DashboardLoadingWidget
    content = content.replace('LoadingStateView()', 'DashboardLoadingWidget()')
    
    # Fix DashboardScaffold -> MasterLayout
    content = content.replace('DashboardScaffold(', 'MasterLayout(\n      child: CustomScrollView(')
    content = content.replace('body: CustomScrollView(', '')
    # This might be tricky because we need to remove the title: '...' and isOffline: ...
    # Let's just use regex
    content = re.sub(r"title:\s*'[^\']+',\s*isOffline:\s*[^,]+,\s*body:\s*CustomScrollView\(", "child: CustomScrollView(", content)
    
    # Fix MetricsRibbon
    content = content.replace('MetricsRibbon(', 'PrimeCareResponsiveKpiGrid(')
    
    # Fix dynamic model
    content = re.sub(r'Widget _buildDashboard\(BuildContext context, dynamic model\) \{', r'Widget _buildDashboard(BuildContext context, dynamic model) {', content) # keep dynamic, it's easier to avoid importing model if we don't know the exact name
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

def fix_controller(path):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    content = content.replace("import 'package:primecare_ui/primecare_ui.dart';\nimport 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart';")
    content = content.replace("import 'package:easy_localization/easy_localization.dart';\n", "")
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

for app_dir in glob.glob(os.path.join(APPS_DIR, '*')):
    if not os.path.isdir(app_dir): continue
    
    app_router = os.path.join(app_dir, 'lib', 'core', 'routing', 'app_router.dart')
    if os.path.exists(app_router):
        fix_app_router(app_router)
        
    main_dart = os.path.join(app_dir, 'lib', 'main.dart')
    if os.path.exists(main_dart):
        fix_main(main_dart)
        
    for root, dirs, files in os.walk(os.path.join(app_dir, 'lib', 'features')):
        for file in files:
            file_path = os.path.join(root, file)
            if file.endswith('_model.dart'):
                fix_model(file_path)
            elif file.endswith('_view.dart'):
                fix_view(file_path)
            elif file.endswith('_controller.dart'):
                fix_controller(file_path)
