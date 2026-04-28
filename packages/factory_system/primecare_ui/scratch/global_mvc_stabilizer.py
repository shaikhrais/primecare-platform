import os
import re

def camel_case(s):
    return ''.join(word.capitalize() for word in s.replace('-', '_').replace('_', ' ').split())

FILES = ['features_view.dart', 'features_controller.dart', 'features_model.dart']
BASE_PATH = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features'

PROTECTED_SYMBOLS = {
    'Widget', 'BuildContext', 'State', 'ConsumerState', 'ConsumerWidget', 
    'StatelessWidget', 'StatefulWidget', 'ref', 'context', 'super', 'this',
    'Result', 'Failure', 'Either', 'Left', 'Right', 'Future', 'Stream',
    'List', 'Map', 'Set', 'Iterable', 'dynamic', 'void', 'bool', 'int', 'double', 'String',
    'dashboardServiceProvider', 'KpiMetric', 'KpiData', 'LocaleKeys', 'tr',
    'PrimeCareColors', 'PrimeCareTheme', 'AppTheme', 'Theme', 'Scaffold', 'Center', 'Column', 'Row',
    'SizedBox', 'Container', 'Text', 'Icon', 'Icons', 'TextField', 'ElevatedButton', 'BoxDecoration',
    'Border', 'BorderRadius', 'EdgeInsets', 'TextStyle', 'Size', 'Duration', 'Color',
    'MainAxisAlignment', 'CrossAxisAlignment', 'MainAxisSize', 'FontWeight', 'TextAlign',
    'BoxShadow', 'Alignment', 'Stack', 'Positioned', 'InkWell', 'GestureDetector', 'SingleChildScrollView',
    'Padding', 'Expanded', 'Flexible', 'Spacer', 'Divider', 'VerticalDivider', 'CircleAvatar',
    'Card', 'ListTile', 'ListView', 'GridView', 'AppBar', 'Drawer', 'BottomNavigationBar',
    'Navigator', 'MaterialPageRoute', 'Route', 'PageRouteBuilder', 'Animation', 'AnimationController',
    'CurvedAnimation', 'Curves', 'Tween', 'AnimatedContainer', 'AnimatedOpacity', 'AnimatedBuilder',
    'Consumer', 'Provider', 'StateProvider', 'FutureProvider', 'StreamProvider', 'NotifierProvider',
    'AsyncValue', 'AsyncData', 'AsyncError', 'AsyncLoading', 'ChangeNotifier', 'StateNotifier',
    'ViewModel', 'Adapter', 'Notifier', 'StatefulHookWidget', 'HookWidget', 'HookConsumerWidget',
    'useMemoized', 'useEffect', 'useCallback', 'useStream', 'useFuture', 'useAnimationController',
    'ScreenRegistry', 'PageTemplate', 'MasterLayout', 'AuraDashboardHud', 'PrimeCareLineChart',
    'PrimeCareResponsiveKpiGrid', 'PrimeCareKpiCard', 'DashboardStateWidgets'
}

def get_blocks(content):
    # Pattern: // --- Start of (dir)/(file) ---
    return re.split(r'(// --- Start of (.*?)/(.*?) ---)', content)

def stabilize():
    print("Mapping symbols...")
    symbol_map = {}
    
    for filename in FILES:
        path = os.path.join(BASE_PATH, filename)
        if not os.path.exists(path):
            print(f"Skipping {filename} (not found)")
            continue
        
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        parts = get_blocks(content)
        for i in range(1, len(parts), 4):
            feature_path = parts[i+1]
            feature_dir = feature_path.split('/')[0]
            block_content = parts[i+3]
            prefix = camel_case(feature_dir)
            
            if feature_dir not in symbol_map:
                symbol_map[feature_dir] = {}
            
            # Find all top-level symbols
            # Using a more inclusive regex for various Dart declarations
            patterns = [
                r'(class|abstract class|mixin|enum|extension)\s+([A-Za-z0-9_]+)',
                r'(final|const|var)\s+([A-Za-z0-9_]+)\s*=',
                r'(void|Future<.*?>|Stream<.*?>|[A-Za-z0-9_<>]+)\s+([A-Za-z0-9_]+)\s*\('
            ]
            
            for pattern in patterns:
                matches = re.findall(pattern, block_content)
                for kind, name in matches:
                    if name in PROTECTED_SYMBOLS: continue
                    if name.startswith(prefix) or name.startswith('_' + prefix): continue
                    if len(name) < 3: continue # Skip short names
                    
                    new_name = prefix + name if not name.startswith('_') else '_' + prefix + name.lstrip('_')
                    symbol_map[feature_dir][name] = new_name
                    # print(f"  Mapped {name} -> {new_name} for feature {feature_dir}")

    print("Applying global stabilization...")
    for filename in FILES:
        path = os.path.join(BASE_PATH, filename)
        if not os.path.exists(path): continue
        
        print(f"  Processing {filename}...")
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        parts = get_blocks(content)
        new_parts = [parts[0]]
        
        for i in range(1, len(parts), 4):
            marker = parts[i]
            feature_dir = parts[i+1].split('/')[0]
            block_content = parts[i+3]
            
            mapping = symbol_map.get(feature_dir, {})
            # Sort mapping by length desc to avoid partial replacements
            sorted_mapping = sorted(mapping.items(), key=lambda x: len(x[0]), reverse=True)
            
            for old_name, new_name in sorted_mapping:
                # Use word boundaries
                block_content = re.sub(r'(?<!\w)' + old_name + r'(?!\w)', new_name, block_content)
            
            new_parts.append(marker)
            new_parts.append(block_content)
            
        with open(path, 'w', encoding='utf-8') as f:
            f.write("".join(new_parts))

    print("Done.")

if __name__ == "__main__":
    stabilize()
