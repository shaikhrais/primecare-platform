# Import/export checker
import re
def check_imports(file_content):
    return re.findall(r"import\s+['\"]([^'\"]+)['\"]", file_content)
