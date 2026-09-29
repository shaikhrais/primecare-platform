import json,sys
from pathlib import Path
from collections import Counter
root=Path(__file__).resolve().parents[1]
rows=json.loads(Path(sys.argv[1]).read_text())
assert len(rows)==64 and len({r['role'] for r in rows})==64, 'Incomplete role audit'
api=Counter(r.get('api_login','not_verified') for r in rows)
ui=Counter(r.get('browser_login','not_verified') for r in rows)
dash=Counter(r.get('dashboard','not_verified') for r in rows)
lines=['# Live all-role dashboard audit','', '64 QA accounts were created and verified in the isolated PrimeCare QA tenant. Existing identities and passwords were not overwritten. The real CEO account was not changed.','', 'Passwords remain in the TEST_DEFAULT_PASSWORD GitHub secret. Test account emails are qa.<role>@test.primecare.local.','', '## Results','',f'- API login and session-role checks: {api.get("passed_with_session_role",0)}/64 passed.',f'- Browser login with visible session identity: {ui.get("passed_session_identity_visible",0)}/64 passed.',f'- Dashboard observations: {dict(dash)}.','- All 64 live API login attempts returned HTTP 403; browser checks were skipped by the API prerequisite. These are blocked/unverified checks, not 64 proven credential failures.', '- Fully functional business dashboards: none verified. Rendering or successful authentication is not proof that buttons, metrics, permissions, persistence, and business workflows work.','', 'Static analysis separately found 40 role entries with simulated success/inactive actions/incomplete API contracts and 24 role entries whose configured landing route is absent from the screen registry.','', '| Role | API session | Browser session | Dashboard | Actual path / failure phase |','|---|---|---|---|---|']
for r in sorted(rows,key=lambda x:x['role']):
 lines.append('| '+' | '.join([r['role'],r.get('api_login','not_verified'),r.get('browser_login','not_verified'),r.get('dashboard','not_verified'),str(r.get('actual_path',r.get('failed_phase',r.get('api_login_status',''))))])+' |')
lines+=['','## Evidence','', '- Provisioning and disposable-database checks: https://github.com/shaikhrais/primecare-platform/actions/runs/36561427430 (provisioning succeeded; the original browser phase was canceled because its selectors needed correction).','- Corrected live audit: https://github.com/shaikhrais/primecare-platform/actions/runs/36561797647', '- Single-request diagnostic: https://github.com/shaikhrais/primecare-platform/actions/runs/36562305065. HTTP 403, plain-text response containing code 1010, no PrimeCare gateway header. This indicates an upstream access rejection; no further login attempts were made. The workflow completed its evidence collection, but did not pass authentication or dashboard acceptance.','', 'The audit does not execute arbitrary dashboard buttons, which could alter business records. Missing end-to-end business acceptance coverage is recorded rather than assumed to pass.']
out=root/'docs/audits/role-dashboards';out.mkdir(parents=True,exist_ok=True)
(out/'RUNTIME_REPORT.md').write_text('\n'.join(lines)+'\n')
(out/'runtime.json').write_text(json.dumps(rows,indent=2)+'\n')
print(json.dumps({'api':dict(api),'browser':dict(ui),'dashboards':dict(dash)},indent=2))
