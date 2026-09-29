"""Authenticated smoke checks; never equate a rendered page with full functionality."""
import json,os,time
from pathlib import Path
from urllib.parse import urlsplit
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
roles=json.loads(Path('docs/audits/role-dashboards/inventory.json').read_text())['roles']
password=os.environ['TEST_DEFAULT_PASSWORD']
results=[]
for role in roles:
 result={'role':role['role_code'],'email':role['test_email'],'login':'not_verified','dashboard':'not_verified','fully_functional':'not_verified','static_findings':role['static_findings']}
 options=webdriver.ChromeOptions();options.add_argument('--headless=new');options.add_argument('--no-sandbox');options.add_argument('--disable-dev-shm-usage');options.add_argument('--window-size=1440,1000')
 driver=None
 try:
  driver=webdriver.Chrome(options=options)
  origin=role['primary_app_url'];assert origin and urlsplit(origin).hostname.endswith('.pages.dev')
  driver.get(origin+'/login?enable-semantics=true')
  wait=WebDriverWait(driver,30)
  email=wait.until(EC.presence_of_element_located((By.XPATH,"//input[@aria-label='login-email'] | //*[@aria-label='login-email']//input")))
  pwd=driver.find_element(By.XPATH,"//input[@aria-label='login-password'] | //*[@aria-label='login-password']//input")
  email.send_keys(role['test_email']);pwd.send_keys(password)
  driver.find_element(By.XPATH,"//*[@aria-label='login-submit']").click()
  wait.until(lambda d: urlsplit(d.current_url).path!='/login')
  path=urlsplit(driver.current_url).path
  result['actual_path']=path;result['expected_path']=role['post_login_route']
  text=driver.find_element(By.TAG_NAME,'body').text
  placeholder=any(s in text.lower() for s in ['fully implemented','100% ready','execute action','not available yet','coming soon'])
  result['dashboard']='placeholder_detected' if placeholder else ('route_mismatch' if path!=role['post_login_route'] else 'rendered_not_functionally_verified')
  driver.get(origin+'/success?enable-semantics=true')
  wait.until(lambda d: role['test_email'] in d.find_element(By.TAG_NAME,'body').text)
  result['login']='passed_session_identity_visible'
 except Exception as error:
  result['error_type']=type(error).__name__ # Never log form contents or response bodies.
 finally:
  if driver:driver.quit()
 results.append(result)
 Path('role-dashboard-runtime.json').write_text(json.dumps(results,indent=2))
 print(role['role_code']+': '+result['login']+' / '+result['dashboard'],flush=True)
print('Completed role smoke checks. Feature workflows still require explicit end-to-end acceptance tests.')
