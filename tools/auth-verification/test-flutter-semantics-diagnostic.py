"""Public presentation diagnostic: intercept a synthetic challenge, no account/DB use."""
import json,re,sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[2]))
from playwright.sync_api import sync_playwright,expect
from tools.deployment.flutter_browser import fill_flutter_field
from tools.deployment.http_client import read_public_asset
SEED='A'*32
SITE='https://primecare-clinic.pages.dev'
OUT=Path('test-results/flutter-semantics-diagnostic');OUT.mkdir(parents=True,exist_ok=True)
report={'syntheticChallenge':True,'serverLoginCalled':False,'accountsChanged':0,'liveAuthProof':False}
try:
 report['build']=json.loads(read_public_asset(SITE+'/primecare-build.json?enable-semantics=true'))
 with sync_playwright() as pw:
  browser=pw.chromium.launch()
  try:
   context=browser.new_context(viewport={'width':320,'height':1000},service_workers='block')
   page=context.new_page()
   page.route('**/v1/auth/login',lambda route:route.fulfill(status=200,headers={'content-type':'application/json','access-control-allow-origin':SITE,'access-control-allow-credentials':'true'},body=json.dumps({'status':'mfa_required','purpose':'enroll','challenge':'B'*43,'setupKey':SEED})))
   page.goto(SITE+'/login?enable-semantics=true',wait_until='domcontentloaded',timeout=60000)
   field=lambda name:page.get_by_role('textbox',name=re.compile('^'+name+r'\b'))
   fill_flutter_field(page,field('login-email'),'diagnostic@example.invalid')
   fill_flutter_field(page,field('login-password'),'Synthetic presentation only!')
   page.locator('[aria-label="login-submit"][role="button"], [aria-label="login-submit"] [role="button"]').click()
   field('mfa-code').wait_for(timeout=30000)
   page.wait_for_timeout(1000)
   report['nodes']=page.locator('flt-semantics, [aria-label]').evaluate_all("(nodes,seed) => nodes.filter(n => (n.getAttribute('aria-label')||'').includes('mfa-seed') || (n.textContent||'').includes(seed) || n.value===seed).map(n => ({tag:n.tagName,role:n.getAttribute('role'),label:(n.getAttribute('aria-label')||'').replaceAll(seed,'[synthetic-key]'),labelHasKey:(n.getAttribute('aria-label')||'').includes(seed),textHasKey:(n.textContent||'').includes(seed),valueHasKey:n.value===seed,focusable:n.getAttribute('tabindex')}))",SEED)
   report['labelLocatorCount']=page.locator('[aria-label^="mfa-seed"]').count()
   page.route('**/v1/auth/mfa',lambda route:route.fulfill(status=401,headers={'content-type':'application/json','access-control-allow-origin':SITE,'access-control-allow-credentials':'true'},body=json.dumps({'error':'MFA verification failed'})))
   fill_flutter_field(page,field('mfa-code'),'123456')
   with page.expect_response(lambda response:response.url.split('?')[0].endswith('/v1/auth/mfa')):
    page.locator('[aria-label="mfa-submit"][role="button"], [aria-label="mfa-submit"] [role="button"]').click()
   try:
    expect(field('mfa-code')).to_have_value('',timeout=5000)
    report['rejectedCodeCleared']=True
   except Exception:report['rejectedCodeCleared']=False
   report['factorFieldFocused']=field('mfa-code').evaluate('(e)=>e.getRootNode().activeElement===e')
   report['hasBrowserAuthority']=page.evaluate("localStorage.getItem('flutter.auth_token')!==null")
   assert report['hasBrowserAuthority'] is False
  finally:browser.close()
except Exception:
 report['failed']=True
 raise RuntimeError('Synthetic Flutter semantics diagnostic failed; no production account was used') from None
finally:
 (OUT/'receipt.json').write_text(json.dumps(report,indent=2));print('FLUTTER_SEMANTICS_DIAGNOSTIC '+json.dumps(report))
