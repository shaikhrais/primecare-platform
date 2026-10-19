from reportlab.pdfgen import canvas
from reportlab.lib.colors import HexColor
from pathlib import Path
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
pdfmetrics.registerFont(TTFont('ReviewRegular','/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf'))
pdfmetrics.registerFont(TTFont('ReviewBold','/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf'))
from PIL import Image
from textwrap import wrap
import json,collections
out=Path('output/pdf/PrimeCare_Admin_Marketing_Review.pdf');c=canvas.Canvas(str(out),pagesize=(595,842));W,H=595,842;page=0;c.setTitle('PrimeCare Admin and Marketing Screen Review');c.setAuthor('PrimeCare Review')
accent=HexColor('#0f766e');ink=HexColor('#17333e')
def start(title,sub=''):
 global page
 page+=1;c.setFillColor(HexColor('#f3f8f8'));c.rect(0,0,W,H,fill=1,stroke=0);c.setFillColor(accent);c.rect(0,H-14,W,14,fill=1,stroke=0);c.setFillColor(ink);title_size=min(20,525/max(1,pdfmetrics.stringWidth(title,'ReviewBold',1)));c.setFont('ReviewBold',title_size);c.drawString(35,H-54,title);c.setFont('ReviewRegular',10);c.drawString(35,H-75,sub);c.setFont('ReviewRegular',8);c.drawString(35,20,'PrimeCare | Local synthetic QA evidence | 14 October 2026');c.drawRightString(W-35,20,str(page))
def para(text,y,size=11):
 c.setFillColor(ink);c.setFont('ReviewRegular',size)
 for line in wrap(text,85 if size==11 else 95):c.drawString(35,y,line);y-=size+6
 return y-8
def screenshot(phase,file,x,y,w,h):
 p=Path('test-results/scoped-review')/phase/file
 if not p.exists():return
 im=Image.open(p);ratio=min(w/im.width,h/im.height);cw,ch=im.width*ratio,im.height*ratio;c.drawImage(str(p),x+(w-cw)/2,y+(h-ch)/2,cw,ch)
def comparison(title,file,comment):
 start(title,'Before and after - same viewport, synthetic data, no live session')
 c.setFont('ReviewBold',12);c.drawString(110,738,'BEFORE');c.drawString(390,738,'AFTER');screenshot('before',file,40,125,235,600);screenshot('after',file,320,125,235,600);para(comment,100,10);c.showPage()
start('Summary: changes and test coverage','Latest platform admin, tenant admin and marketing review')
y=720
for txt in ['2 main application screens modified: Platform Administration (/platform/administration) and Founder Growth / Marketing (/growth). Platform and tenant administrators share the first screen.','2 nested UI areas updated: the shared Reports panel and the Screen text editor. These are components/views, not additional independent route screens.','78 role/view combinations reviewed across 9 roles. These combinations reuse the main application screens; they are not 78 separately modified screens.','154 before screenshots and 156 after screenshots. Each view was captured at mobile and desktop widths. The two extra captures show tenant-admin Reports becoming reachable.','58 targeted tests passed: 8 administrator browser cases, 34 marketing browser cases and 16 reporting API/integration cases.','2 viewport widths tested: 320 and 1440 pixels. Physical devices tested: 0. Verified web deployments: 0.','Main corrections: report navigation and PDF access, mobile table readability, preview row counts, report language inheritance and duplicate tenant navigation.','Current status: locally implemented and verified. Publishing was blocked by a 403 CONNECT tunnel response. No production update is claimed.']:
 y=para(txt,y)
c.showPage()
start('Devices and screen sizes tested','Browser layout simulation on Linux - not physical-device certification')
y=720
for txt in ['Browser: headless Chromium controlled by Playwright on a Linux execution environment. The tests changed browser viewport size; they did not use actual phones, tablets or Windows/Mac computers.','Screenshot review: 320 x 1000 pixels for a narrow phone-style layout and 1440 x 1000 pixels for a desktop-style layout. All 9 in-scope roles were captured at both sizes.','Functional browser regressions: 320 x 1200 and 1440 x 1200 pixels. Admin and primary marketing workflows ran in English, French and Spanish. Staff-role scope checks provide separate functional coverage; not every combination of role, action and language was tested.','Tested: browser rendering, role-visible navigation, no page-level horizontal overflow, admin form retry behavior, cross-tenant draft boundaries, report generation and PDF download headers.','Not tested on physical hardware: Android, iPhone/iPad, Windows, macOS, Linux desktop machines or native applications. No touch, camera, biometric or native installation acceptance is claimed.','Not fully certified: accessibility with assistive technology, every browser, tablet widths, 4K layout, slow-network behavior or all populated/empty/error states.','Database test runtime: isolated PGlite schemas using the real API handlers. CI is configured for PostgreSQL 16; a successful production database run is not claimed.']:
 y=para(txt,y)
c.showPage()
review=json.loads(Path('docs/appearance/report-ui-review/after.json').read_text());before=json.loads(Path('docs/appearance/report-ui-review/before.json').read_text())
roles=['platform_admin','tenant_admin','marketing','growth_caller','growth_google','growth_meta','growth_seo','growth_offline','growth_coordinator']
names={'platform_admin':'Platform administrator','tenant_admin':'Tenant administrator','marketing':'Marketing manager','growth_caller':'Telephone caller','growth_google':'Google marketing specialist','growth_meta':'Facebook / Meta specialist','growth_seo':'SEO specialist','growth_offline':'Offline campaign specialist','growth_coordinator':'Marketing coordinator'}
start('Review count by role','View combinations and captures - not unique modified route screens')
c.setFont('ReviewBold',10)
for x,t in [(35,'Role'),(270,'Views'),(350,'Before'),(435,'After')]:c.drawString(x,718,t)
y=685
for role in roles:
 views={e['view'] for e in review['evidence'] if e.get('file') and e['role']==role};b=sum(e.get('file') is not None for e in before['evidence'] if e['role']==role);a=sum(e.get('file') is not None for e in review['evidence'] if e['role']==role)
 c.setFont('ReviewRegular',10);c.drawString(35,y,names[role]);c.drawString(285,y,str(len(views)));c.drawString(365,y,str(b));c.drawString(445,y,str(a));c.setStrokeColor(HexColor('#cbdede'));c.line(35,y-14,560,y-14);y-=43
c.setFont('ReviewBold',11);c.drawString(35,y,'TOTAL');c.drawString(285,y,'78');c.drawString(365,y,'154');c.drawString(445,y,'156');y=para('Each view count is multiplied by two viewport widths to produce the after-capture count. Only tenant-admin Reports was newly reachable in this review. Existing platform-admin reports remained accessible.',y-52)
c.showPage()
for title,selected in [('Admin and marketing views reviewed',['platform_admin','tenant_admin','marketing']),('Marketing specialist views reviewed',roles[3:])]:
 start(title,'Inventory of the actual visible view states captured')
 y=720
 for role in selected:
  views=sorted({e['view'] for e in review['evidence'] if e.get('file') and e['role']==role});labels=[v.removeprefix('growth-').replace('_',' ').replace('-',' ').title() for v in views]
  c.setFont('ReviewBold',12);c.drawString(35,y,names[role]);y-=27;y=para(', '.join(labels)+'.',y,10)
 if 'platform_admin' in selected:
  y=para('Modification detail: the shared admin screen gained server-authorized report navigation, inherited report language, a cleaner tenant menu and readable mobile tables. Tenant administration reuses this same route screen.',y-8,10)
  y=para('The marketing screen gained a report shortcut and readable, focusable table scroll areas. The Reports panel gained shown/total preview counts and a review-PDF link. Text-editor table presentation improved; its mutations were not certified by this screenshot sweep.',y,10)
 y=para('Full-resolution before/after images for every listed view are included in the screenshot archive. Some captures show adjacent sections because they are scroll positions inside one application screen.',max(70,y-12),10)
 c.showPage()
start('Admin and marketing screen review','Review, correction and recapture record')
y=para('Scope: platform administrator, tenant administrator and marketing, including callers, Google, Facebook, SEO, offline and coordinator roles. Other clinical and client portals were outside this review.',720)
y=para('Captured 154 before views and 156 after views at 320 and 1440 pixels. These are initial and empty states using isolated fixtures, not production results. The two added views are tenant-admin Reports at both widths.',y)
y=para('Main corrections: expose existing authorized reports; add marketing report navigation; keep table columns readable on mobile; show preview row counts; remove duplicate tenant selection links; carry the admin language into the report panel.',y)
y=para('Validation: 58 relevant regression tests passed (42 admin/marketing browser cases and 16 reporting API/integration cases). Screenshot sweeps found no page-level horizontal overflow. Both review schemas were removed and verified.',y)
y=para('Release status: publication was attempted but git push returned a 403 CONNECT tunnel response. No deployment or authenticated live after-screenshot is verified. Cloudflare secrets are absent locally and connected GitHub tools do not expose workflow dispatch.',y)
y=para('Critical judgment: the reviewed appearance is clearer, but this is not a full production approval. Account and live-text service dependencies, native devices, live email delivery and external advertising connections need separate evidence.',y)
c.showPage()
start('Tenant admin: report access','Before: no Reports navigation. After: existing reports are reachable.')
screenshot('before','tenant_admin-accounts-1440.png',35,435,525,320);screenshot('after','tenant_admin-reports-1440.png',35,90,525,320);para('The sidebar now exposes Reports using a server-derived capability. The same report grants remain in force: tenant admins cannot download the global platform report. Select a report, generate a preview and download its server-generated PDF.',68,9);c.showPage()
comparison('Marketing: mobile table readability','marketing-growth-campaigns-320.png','Critical issue corrected: columns previously squeezed text into vertical letters. Tables now keep readable column widths and scroll inside a focusable region. The page itself does not overflow.')
comparison('Marketing: performance reports','marketing-growth-performance-320.png','Performance reports are now reachable from the sidebar when the API permits reporting. Report tables keep readable columns. The report dates and PDF export remain owned by the existing API.')
comparison('Platform admin: mobile account list','platform_admin-accounts-320.png','Account list columns now remain readable on small screens. Creation, account changes and session revocation remain server-authorized actions; this visual correction does not alter permissions.')
start('How to open and download reports','Operational reports and the review document are accessible from the UI')
y=720
for txt in ['1. Sign in as platform or tenant administrator and choose Reports in the sidebar.','2. Choose the report and language. Page readiness supports search and readiness filters.','3. Select Generate, inspect the classification, scope and preview row count, then select Download PDF.','4. Marketing users select Performance reports in the sidebar, choose the dates, run the report and download PDF.','5. The admin report panel includes a Screen review document download containing this review.','Platform admin: authorized page readiness and existing global tenant account/master totals. Tenant admin: its already authorized page report; global platform totals are rejected. Marketing: existing tenant and acquisition performance reporting.','Email remains an explicit recipient-confirmed operation. No real email was sent during this review. A provider acceptance is not proof of inbox delivery.']:
 y=para(txt,y)
c.showPage()
start('Critical assessment and remaining work','What changed, what was checked, and what is not yet proven')
y=720
for txt in ['Fixed: tenant report visibility, missing marketing report shortcut, unreadable mobile table headings, undisclosed 50-row preview limit, duplicate tenant navigation and initial report-language mismatch.','Appearance review: all captures were inspected in contact sheets; key corrections were also inspected at original resolution. Screenshot approval does not certify every interactive state or accessibility requirement.','Functional evidence: reports were generated and PDF headers verified through the real reporting handler in an isolated PostgreSQL-compatible test schema. Tenant access to the global platform report returned 403.','Dependency limits: account and live-text routes are unavailable in the capture fixture. Their screens are recorded, but their mutations are not certified by this sweep. Dedicated action tests provide separate admin and marketing evidence.','External marketing: Google/Facebook attribution is manual in the current product. No live advertising account, automatic spend synchronization or campaign delivery was verified.','Deployment: use the established Cloudflare release workflow for the tested source. The screenshot archive includes before/after local captures and machine-readable inventory; it contains no authenticated live deployment screenshots.','Next release check: verify backend capability and report resources on the deployed API, then sign in with disposable authorized production QA accounts, download each allowed PDF and recapture the deployed report screens.']:
 y=para(txt,y)
c.showPage();c.save();print(out)
