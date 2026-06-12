import sqlite3

def main():
    conn = sqlite3.connect('.agents/governance/governance.db')
    cur = conn.cursor()
    for t in ('orgs', 'apps', 'roles', 'screens'):
        cur.execute(f'PRAGMA table_info({t})')
        # row[1] is name, row[3] is notnull flag, row[4] is default_value
        not_null_cols = [(row[1], row[4]) for row in cur.fetchall() if row[3] != 0]
        print(t, 'not null:', not_null_cols)
    conn.close()

if __name__ == '__main__':
    main()
