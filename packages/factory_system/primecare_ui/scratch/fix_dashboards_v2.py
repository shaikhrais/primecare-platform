
import sys
import re

def fix_dashboards(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Pattern for the build method and the following buildContent
    
    segments = re.split(r'(viewModel as LocalMarketingManagerDashboardViewModel)', content)
    
    new_content = segments[0]
    for i in range(1, len(segments), 2):
        # segments[i] is "viewModel as LocalMarketingManagerDashboardViewModel"
        # segments[i+1] is the text after the cast until the next cast or end of file
        
        # Look for the next _buildContent in segments[i+1]
        # allowing any parameter name instead of just vm
        match = re.search(r'Widget _buildContent\(\s*BuildContext context,\s*PrimeCareThemeData theme,\s*(\w+)\s+\w+', segments[i+1])
        if match:
            vm_type = match.group(1)
            new_content += f'viewModel as {vm_type}'
        else:
            new_content += segments[i]
            
        new_content += segments[i+1]

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)

if __name__ == "__main__":
    fix_dashboards(sys.argv[1])
