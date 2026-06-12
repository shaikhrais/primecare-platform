import re

def main():
    content = open('tools/governance/d1_schema.sql', encoding='utf-8').read()
    match = re.search(r'CREATE TABLE roles\s*\((.*?)\);', content, re.DOTALL)
    if match:
        inner = match.group(1)
        # Find where test_login_last_run_at is
        idx = inner.find('test_login_last_run_at')
        if idx != -1:
            print("Sub-string around test_login_last_run_at:")
            print(inner[idx-50:idx+200])

if __name__ == '__main__':
    main()
