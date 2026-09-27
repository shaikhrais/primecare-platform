import re

def main():
    content = open('tools/governance/d1_schema.sql', encoding='utf-8').read()
    for t in ('apps', 'roles', 'orgs'):
        match = re.search(r'CREATE TABLE ' + t + r'\s*\((.*?)\);', content, re.DOTALL)
        if match:
            print(f"--- Schema for {t} ---")
            print(match.group(0))

if __name__ == '__main__':
    main()
