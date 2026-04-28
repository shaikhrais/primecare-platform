
import sys
import re

def fix_dashboards(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Pattern for the build method and the following buildContent
    # Group 1: Provider name (e.g. hrDirectorDashboardAdapterProvider)
    # Group 2: The cast (LocalMarketingManagerDashboardViewModel)
    # Group 3: Provider name in retry (e.g. customerSupportDashboardAdapterProvider)
    # Group 4: The _buildContent signature and the actual ViewModel type
    
    # We'll do it in two steps. 
    # Step 1: Fix casting based on _buildContent signature.
    
    # Find all _buildContent signatures to create a map of View class -> ViewModel type
    # But these are classes, so we can just look for the next _buildContent after the cast.
    
    segments = re.split(r'(viewModel as LocalMarketingManagerDashboardViewModel)', content)
    
    new_content = segments[0]
    for i in range(1, len(segments), 2):
        # segments[i] is "viewModel as LocalMarketingManagerDashboardViewModel"
        # segments[i+1] is the text after the cast until the next cast or end of file
        
        # Look for the next _buildContent in segments[i+1]
        match = re.search(r'Widget _buildContent\(\s*BuildContext context,\s*PrimeCareThemeData theme,\s*(\w+)\s+vm', segments[i+1])
        if match:
            vm_type = match.group(1)
            new_content += f'viewModel as {vm_type}'
        else:
            # Fallback if not found (shouldn't happen with our file structure)
            new_content += segments[i]
            
        new_content += segments[i+1]

    # Step 2: Fix onRetry providers.
    # Look for the provider watched in the same build method.
    
    # Find the pattern: ref.watch((\w+)); ... onRetry: () => ref.refresh(customerSupportDashboardAdapterProvider)
    
    def replace_provider(match):
        watched_provider = match.group(1)
        rest_of_build = match.group(2)
        # Replace all instances of customerSupportDashboardAdapterProvider in this build method's scope
        fixed_rest = rest_of_build.replace('customerSupportDashboardAdapterProvider', watched_provider)
        return f'ref.watch({watched_provider}){fixed_rest}'

    # This regex is a bit risky due to nesting, but let's try to match until the end of the build method (MasterLayout closure)
    # Actually, let's just match ref.watch(...) and then the next few onRetry occurrences.
    
    new_content = re.sub(r'ref\.watch\((\w+)\)(.*?onRetry: \(\) => ref\.refresh\()customerSupportDashboardAdapterProvider(\))', 
                         r'ref.watch(\1)\2\1\3', new_content, flags=re.DOTALL)
    
    # Repeat a few times for the two onRetry calls (fold and error)
    new_content = re.sub(r'ref\.watch\((\w+)\)(.*?onRetry: \(\) => ref\.refresh\()customerSupportDashboardAdapterProvider(\))', 
                         r'ref.watch(\1)\2\1\3', new_content, flags=re.DOTALL)

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)

if __name__ == "__main__":
    fix_dashboards(sys.argv[1])
