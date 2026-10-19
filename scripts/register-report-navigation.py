"""Bind existing server-authorized reporting to the existing admin screen."""
import json,sqlite3,argparse,runpy
from pathlib import Path
root=Path(__file__).resolve().parents[1];p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');a=p.parse_args();source=sqlite3.connect(root/'.agents/governance/governance.db');db=sqlite3.connect(':memory:') if a.check else source
if a.check:source.backup(db)
sid=db.execute("SELECT id FROM screens WHERE screen_code='PLATFORM_ADMINISTRATION'").fetchone()[0]
db.execute('INSERT OR REPLACE INTO shared_report_surfaces VALUES(?,?,?)',(sid,'shared_reports',json.dumps([{'key':'reports','component':'PrimeButton','testId':'platform-nav-reports','resource':'platform_administration.reports'},{'key':'preview_count','component':'PrimeText','testId':'report-preview-count','resource':'reports.preview_count'}])))
db.execute('CREATE TABLE IF NOT EXISTS report_document_registry(document_id TEXT PRIMARY KEY,resource_key TEXT NOT NULL,file_path TEXT NOT NULL,download_path TEXT NOT NULL,deployment_verified INTEGER NOT NULL DEFAULT 0)')
db.execute('INSERT OR REPLACE INTO report_document_registry VALUES(?,?,?,?,?)',('admin-marketing-screen-review','reports.review_document','websites/typescript/public/assets/reviews/PrimeCare_Admin_Marketing_Review.pdf','/assets/reviews/PrimeCare_Admin_Marketing_Review.pdf',0))
db.execute('CREATE TABLE IF NOT EXISTS report_navigation_policy(id TEXT PRIMARY KEY,definition TEXT NOT NULL)');db.execute('INSERT OR REPLACE INTO report_navigation_policy VALUES(?,?)',('report-nav-v1',json.dumps({'source':'shared_report_grants','adminControl':'platform-nav-reports','marketingControl':'growth-nav-performance','scope':'existing authorized reports only'})));db.commit();content=runpy.run_path(str(root/'scripts/register-admin-reports.py'))['export'](db);target=root/'cloudflare/workers/src/report-registry.json'
if a.check:assert target.read_text()==content
else:target.write_text(content)
print('Registered existing report navigation without changing report grants')
