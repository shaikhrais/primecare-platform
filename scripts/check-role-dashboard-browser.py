"""Authenticated role smoke checks, separate from full feature acceptance."""
import json,os
from pathlib import Path
from urllib.parse import urlsplit
from urllib.request import Request,urlopen
from urllib.error import HTTPError
from concurrent.futures import ThreadPoolExecutor,as_completed
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
roles=json.loads(Path('docs/audits/role-dashboards/inventory.json').read_text())['roles']
password=os.environ['TEST_DEFAULT_PASSWORD']
base='https://primecare-api-gateway.itpro-mohammed.workers.dev'
def api(path,method='GET',payload=None,token=None):
 headers={'Content-Type':'application/json'}
 if token:headers['Authorization']='Bearer '+token
 req=Request(base+path,data=json.dumps(payload).encode() if payload is not None else None,headers=headers,method=method)
 try:
  with urlopen(req,timeout=20) as r:return r.status,json.load(r)
 except HTTPError as e:return e.code,{}
def check(role):
 result={'role':role['role_code'],'email':role['test_email'],'api_login':'not_verified','browser_login':'not_verified','dashboard':'not_verified','fully_functional':'not_verified','static_findings':role['static_findings']}
 token=None;driver=None;phase='api_login'
 try:
  code,login=api('/v1/auth/login','POST',{'email':role['test_email'],'password':password})
  result['api_login_status']=code
  if code!=200 or login.get('role')!=role['role_code']:return result
  token=login.get('token');assert token
  code,me=api('/v1/auth/me',token=token)
  if code!=200 or me.get('roles')!=role['role_code']:return result
  result['api_login']='passed_with_session_role'
  options=webdriver.ChromeOptions();options.add_argument('--headless=new');options.add_argument('--no-sandbox');options.add_argument('--disable-dev-shm-usage');options.add_argument('--window-size=1440,1000')
  driver=webdriver.Chrome(options=options);driver.set_page_load_timeout(45)
  origin=role['primary_app_url'];assert origin and urlsplit(origin).hostname.endswith('.pages.dev')
  phase='login_fields';driver.get(origin+'/login?enable-semantics=true');wait=WebDriverWait(driver,35)
  email=wait.until(EC.presence_of_element_located((By.XPATH,"//input[starts-with(@aria-label,'login-email')]")))
  pwd=driver.find_element(By.XPATH,"//input[starts-with(@aria-label,'login-password')]")
  email.send_keys(role['test_email']);pwd.send_keys(password)
  driver.find_element(By.XPATH,"//*[@aria-label='login-submit']").click()
  phase='dashboard_navigation';wait.until(lambda d:urlsplit(d.current_url).path!='/login')
  path=urlsplit(driver.current_url).path;result['actual_path']=path;result['expected_path']=role['post_login_route']
  text=driver.find_element(By.TAG_NAME,'body').text
  placeholder=any(s in text.lower() for s in ['fully implemented','100% ready','execute action','not available yet','coming soon'])
  result['dashboard']='placeholder_detected' if placeholder else ('route_mismatch' if path!=role['post_login_route'] else 'rendered_not_functionally_verified')
  phase='session_identity';driver.get(origin+'/success?enable-semantics=true')
  wait.until(lambda d:role['test_email'] in d.find_element(By.TAG_NAME,'body').text)
  result['browser_login']='passed_session_identity_visible'
  buttons=driver.find_elements(By.XPATH,"//*[@role='button' and @aria-label='Sign out']")
  if buttons:buttons[0].click()
 except Exception as error:
  result['error_type']=type(error).__name__;result['failed_phase']=phase
 finally:
  if driver:driver.quit()
  if token:
   try:api('/v1/auth/logout','POST',{},token)
   except Exception:result['api_logout']='not_verified'
 return result
results=[]
with ThreadPoolExecutor(max_workers=3) as pool:
 futures=[pool.submit(check,r) for r in roles]
 for future in as_completed(futures):
  result=future.result();results.append(result)
  Path('role-dashboard-runtime.json').write_text(json.dumps(sorted(results,key=lambda r:r['role']),indent=2))
  print(f"{len(results)}/{len(roles)} {result['role']}: {result['api_login']} / {result['browser_login']} / {result['dashboard']}",flush=True)
print('Role smoke checks completed. Full business workflows remain unverified.')
