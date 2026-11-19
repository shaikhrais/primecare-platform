"""Report exact dashboard ownership and existing active staff grants; never write."""
import argparse
import json
from pathlib import Path

def read_bindings(db, codes):
    report=[]
    for code in codes:
        screens=db.execute(
            'SELECT id, app_id, role_id, route_path, active FROM screens WHERE screen_code=? ORDER BY id',
            (code,),
        ).fetchall()
        if len(screens)!=1:
            report.append({'screen':code,'registryRows':len(screens),'gate':'missing_or_ambiguous'})
            continue
        sid,app,owner,route,active=screens[0]
        owned=db.execute(
            'SELECT role_code, active, primary_app_code, post_login_route FROM roles WHERE id=?',(owner,)
        ).fetchall()
        owner_code, owner_active, owner_app, landing=owned[0] if len(owned)==1 else (None,None,None,None)
        grants=sorted({r[0] for r in db.execute(
            'SELECT r.role_code FROM role_screen_permissions p JOIN roles r ON r.id=p.role_id WHERE p.screen_id=? AND p.can_view=1 AND r.active=1',
            (sid,),
        ).fetchall()})
        valid=bool(active==1 and owner_active==1 and owner_code and owner_code.lower()!='guest' and owner_code in grants)
        report.append({'screen':code,'id':sid,'appId':app,'route':route,'registeredOwner':owner_code,'ownerApp':owner_app,
            'ownerHasView':owner_code in grants, 'ownerLandingMatches':bool(landing and landing==route),
            'activeStaffViewRoles':[g for g in grants if g.lower()!='guest'],
            'gate':'check_existing_binding' if valid else 'hold'})
    return report

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('inventory',type=Path)
    args=parser.parse_args()
    try:
        codes=json.loads(args.inventory.read_text())
        if len(codes)!=26 or len(set(codes))!=26: raise ValueError('Expected 26 unique screen codes')
        from production_reader import connect
        with connect() as db:
            report=read_bindings(db,codes)
        for row in report: print(json.dumps(row,sort_keys=True))
        print(json.dumps({'screenCount':len(report),'existingStaffBindingCandidates':sum(x['gate']=='check_existing_binding' for x in report),'writesAttempted':False}))
    except Exception:
        raise SystemExit('Ownership audit failed; database and connection details suppressed.') from None

if __name__=='__main__': main()
