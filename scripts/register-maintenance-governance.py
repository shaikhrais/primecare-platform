"""Register maintenance role and screen metadata without granting other screens."""
import sqlite3
from pathlib import Path
repo = Path(__file__).resolve().parents[1]
with sqlite3.connect(repo / '.agents/governance/governance.db') as db:
    db.execute("INSERT OR IGNORE INTO roles(role_code,role_name,role_type,active,primary_app_code,post_login_route) VALUES('maintenance','IT Maintenance','Infrastructure',1,'SU','/maintenance/configuration')")
    role = db.execute("SELECT id FROM roles WHERE role_code='maintenance'").fetchone()[0]
    app = db.execute("SELECT id FROM apps WHERE app_code='SU'").fetchone()
    db.execute("INSERT OR IGNORE INTO screens(app_id,role_id,screen_code,screen_name,route_path,actual_file_path,stage,active,implementation_tag,content_tag,api_tag,test_tag) VALUES(?,?,'MAINTENANCE_CONFIGURATION','IT Maintenance Configuration','/maintenance/configuration','packages/primecare_ui/lib/src/features/maintenance/maintenance_configuration_screen.dart','implemented',1,'implemented','implemented','implemented','unit_tested')", (app[0] if app else None, role))
    screen = db.execute("SELECT id FROM screens WHERE screen_code='MAINTENANCE_CONFIGURATION'").fetchone()[0]
    for code in ['maintenance','ceo']:
        r = db.execute('SELECT id FROM roles WHERE role_code=?', (code,)).fetchone()
        if r: db.execute('INSERT OR IGNORE INTO role_screen_permissions(role_id,screen_id,can_view,can_create,can_edit) VALUES(?,?,1,1,1)',(r[0],screen))
