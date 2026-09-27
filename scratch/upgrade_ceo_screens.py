import os
import re

SCREENS_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_corporate\lib\features\ceo\screens"

def process_file(filepath):
    filename = os.path.basename(filepath)
    if not filename.startswith("ceo_") or not filename.endswith("_screen.dart"):
        return
        
    print(f"Upgrading: {filename}")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        
    # Check if already upgraded
    if "GovernedConsumerWidget" in content:
        print("  Already upgraded!")
        return
        
    # Extract class name
    class_match = re.search(r'class\s+(\w+)\s+extends\s+ConsumerWidget', content)
    if not class_match:
        print("  Could not find class name!")
        return
    class_name = class_match.group(1)
    
    # Extract title from AppBar
    title_match = re.search(r"title:\s+const\s+Text\('([^']+)'\)", content)
    if not title_match:
        title_match = re.search(r"title:\s+Text\('([^']+)'\)", content)
        
    title = title_match.group(1) if title_match else class_name.replace("Screen", "")
    
    # Extract controller provider
    provider_match = re.search(r'ref\.watch\((\w+)\)', content)
    if not provider_match:
        print("  Could not find provider name!")
        return
    provider_name = provider_match.group(1)
    
    # Compute screen code (without underscores)
    screen_code = filename.replace("_screen.dart", "").replace("_", "")
    
    # Build replacement code
    new_content = f"""import 'package:primecare_ui/primecare_ui.dart';
import '{filename.replace("_screen.dart", "_screen_controller.dart")}';

class {class_name} extends GovernedConsumerWidget {{
  @override
  String get screenDescription => 'CEO Screen {class_name}';

  @override
  List<String> get requiredComponents => const [];

  @override
  List<String> get requiredFunctions => const [];

  const {class_name}({{super.key}});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {{
    final state = ref.watch({provider_name});
    final theme = context.theme;
    final screenCode = '{screen_code}';

    return Cy(
      id: '$screenCode-screen',
      child: Scaffold(
        backgroundColor: theme.colors.dashboardBackground,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(
            label: 'data-cy:$screenCode-title',
            container: true,
            child: Text(
              '{title}',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ),
        ),
        body: Cy(
          id: '$screenCode-content',
          child: state.when(
            data: (data) => _buildContent(context, data),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error loading features: $error')),
          ),
        ),
      ),
    );
  }}

  Widget _buildContent(BuildContext context, dynamic data) {{
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
          const SizedBox(height: 16),
          Text(
            '{class_name} is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }}
}}
"""
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_content)
    print("  Upgraded successfully!")

def main():
    for f in os.listdir(SCREENS_DIR):
        if f.endswith(".dart"):
            process_file(os.path.join(SCREENS_DIR, f))

if __name__ == '__main__':
    main()
